//
//  SIPickView.m
//  SIUIKit
//
//  Created by Silence on 2019/4/16.
//  Copyright © 2019年 Silence. All rights reserved.
//

#import "SIPickView.h"

#define IS_IPHONE_X_ALL \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})
#define PICKWIDTH_HEIGHT         (IS_IPHONE_X_ALL ?  224 + 34.f : 224)

static const CGFloat toolViewHeight = 44.0f; // tool view height
static const CGFloat canceBtnWidth = 68.0f; // cance button or sure button height
@implementation SIPickViewConfig

+ (instancetype)defaultConfig {
    SIPickViewConfig *defaultConfig = [[SIPickViewConfig alloc]init];
    defaultConfig.pickViewHeight = PICKWIDTH_HEIGHT;
    defaultConfig.componetRowHeight = 32.f;
    defaultConfig.selectRowTitleAttribute = [@{NSForegroundColorAttributeName : [UIColor orangeColor], NSFontAttributeName : [UIFont systemFontOfSize:20.0f]} mutableCopy];
    defaultConfig.unSelectRowTitleAttribute = [@{NSForegroundColorAttributeName : [UIColor lightGrayColor], NSFontAttributeName : [UIFont systemFontOfSize:20.0f]} mutableCopy];
    defaultConfig.selectRowLineBackgroundColor = [UIColor colorWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1.0];
    defaultConfig.isTouchBackgroundHide = YES;
    defaultConfig.isShowTipLabel = NO;
    defaultConfig.isShowSelectContent = NO;
    defaultConfig.isScrollToSelectedRow = NO;
    defaultConfig.isAnimationShow = YES;
    defaultConfig.backgroundAlpha = 0.5f;
    return defaultConfig;
}

@end

@interface SIPickView ()<UIPickerViewDataSource, UIPickerViewDelegate>
// property
@property (nonatomic, strong) NSArray *dataList; // data list
@property (copy, nonatomic) SIPickViewClickAction completion;
@property (nonatomic, strong) SIPickViewConfig *config;

@property (nonatomic, assign) NSUInteger component;
@property (nonatomic, assign) BOOL isSettedSelectRowLineBackgroundColor;


// subviews
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIButton *canceBtn;
@property (nonatomic, strong) UIButton *sureBtn;
@property (nonatomic, strong) UILabel *tipLabel;
@property (nonatomic, strong) UIView *lineView;

@end

@implementation SIPickView

- (instancetype)initWithDataSouce:(NSArray *)dataSource
                           config:(SIPickViewConfig *)config
                      clickAction:(SIPickViewClickAction)action {
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        if (!config) {
            self.config = [SIPickViewConfig defaultConfig];
        }else {
            self.config = config;
        }
        self.component = 0;
        self.completion = action;
        self.dataList = dataSource;
        [self initSubViews];
        [self updatePickViewConfig];
    }
    return self;
}

- (void)setDataList:(NSMutableArray *)dataList {
    _dataList = dataList;
    id data = dataList.firstObject;
    if ([data isKindOfClass:[NSString class]] ||
        [data isKindOfClass:[NSNumber class]] ) {
        _component = 1;
    }else if ([data isKindOfClass:[NSDictionary class]]) {
        _component++;
        [self handleDictDataList:dataList];
    }else {
        NSLog(@"数据异常");
    }
}

- (void)handleDictDataList:(NSArray *)list{
    id data = list.firstObject;
    if ([data isKindOfClass:[NSDictionary class]]) {
        NSDictionary *dict = data;
        id value = dict.allValues.firstObject;
        if ([value isKindOfClass:[NSArray class]]) {
            self.component++;
            [self handleDictDataList:value];
        }
    }
}

- (void)updatePickViewConfig {
    if (_config.cancelBtnTitle.length > 0) {
         [self.canceBtn setTitle:_config.cancelBtnTitle forState:UIControlStateNormal];
    }
    if (_config.sureBtnTitle.length > 0) {
        [self.sureBtn setTitle:_config.sureBtnTitle forState:UIControlStateNormal];
    }
    if (_config.tipTitle.length > 0) {
        self.tipLabel.text = _config.tipTitle;
    }
    if (_config.cancelBtnTitleColor) {
        [self.canceBtn setTitleColor:_config.cancelBtnTitleColor forState:UIControlStateNormal];
    }
    if (_config.sureBtnTitleColor) {
         [self.sureBtn setTitleColor:_config.sureBtnTitleColor forState:UIControlStateNormal];
    }
    if (_config.tipTitleColor) {
        self.tipLabel.textColor = _config.tipTitleColor;
    }
    if (_config.lineViewColor) {
        self.lineView.backgroundColor = _config.lineViewColor;
    }
    if (_config.cancelBtnTitleFont) {
        [self.canceBtn.titleLabel setFont:_config.cancelBtnTitleFont];
    }
    if (_config.sureBtnTitleFont) {
        [self.sureBtn.titleLabel setFont:_config.sureBtnTitleFont];
    }
    if (_config.tipTitleFont) {
        [self.tipLabel setFont:_config.tipTitleFont];
    }
    
    self.tipLabel.hidden = !_config.isShowTipLabel;
    if (_config.isShowSelectContent) {
        self.tipLabel.hidden = NO;
    }
    self.backgroundView.alpha = _config.backgroundAlpha;
}

- (void)initSubViews
{
    // background view
    UIView *backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    backgroundView.backgroundColor = [UIColor blackColor];
    backgroundView.alpha = self.config.backgroundAlpha;
    [self addSubview:backgroundView];
    
    // add tap Gesture
    UITapGestureRecognizer *tapbgGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchBackgroundView)];
    [backgroundView addGestureRecognizer:tapbgGesture];
    
    // content view
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - toolViewHeight - self.config.pickViewHeight, self.frame.size.width, toolViewHeight + self.config.pickViewHeight)];
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    
    // tool view
    UIView *toolView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, toolViewHeight)];
    toolView.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:toolView];
    
    // cance button
    NSArray *diffLanguageTitles = [self getDiffLanguageCanceAndSureBtnTitles];
    UIButton *canceBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    canceBtn.frame = CGRectMake(0, 0, canceBtnWidth, toolView.frame.size.height);
    [canceBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [canceBtn setTitle:diffLanguageTitles.firstObject forState:UIControlStateNormal];
    [canceBtn.titleLabel setFont:[UIFont systemFontOfSize:17.0]];
    [canceBtn setTag:0];
    [canceBtn addTarget:self action:@selector(userAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:canceBtn];
    
    // sure button
    UIButton *sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sureBtn.frame = CGRectMake(toolView.frame.size.width - canceBtnWidth, 0, canceBtnWidth, toolView.frame.size.height);
    [sureBtn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [sureBtn setTitle:diffLanguageTitles.lastObject forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:[UIFont systemFontOfSize:17.0]];
    [sureBtn setTag:1];
    [sureBtn addTarget:self action:@selector(userAction:) forControlEvents:UIControlEventTouchUpInside];
    [toolView addSubview:sureBtn];
    
    // center title
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(canceBtn.frame.size.width, 0, toolView.frame.size.width - canceBtn.frame.size.width*2, toolView.frame.size.height)];
    tipLabel.text = @"";
    tipLabel.textColor = [UIColor darkTextColor];
    tipLabel.font = [UIFont systemFontOfSize:17.0];
    tipLabel.textAlignment = NSTextAlignmentCenter;
    tipLabel.hidden = !self.config.isShowTipLabel;
    [toolView addSubview:tipLabel];
    
    // line view
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, toolView.frame.size.height - 0.5f, self.frame.size.width, 0.5f)];
    lineView.backgroundColor = [UIColor colorWithRed:222.0/255.0 green:222.0/255.0 blue:222.0/255.0 alpha:1.0];
    [toolView addSubview:lineView];
    
    // pickerView
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, toolView.frame.size.height, self.frame.size.width, self.config.pickViewHeight)];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [contentView addSubview:pickerView];
    
    // global variable
    self.backgroundView = backgroundView;
    self.contentView = contentView;
    self.canceBtn = canceBtn;
    self.sureBtn = sureBtn;
    self.lineView = lineView;
    self.tipLabel = tipLabel;
    self.pickerView = pickerView;
}

- (void)userAction:(UIButton *)sender {
    // hide
    [self hide];
    // click sure
    if (sender.tag == 1) {
        NSMutableString *selectString = [[NSMutableString alloc] init];
        for (NSUInteger i = 0; i < self.component; i++) {
            [selectString appendString:[self pickerView:self.pickerView titleForRow:[self.pickerView selectedRowInComponent:i] forComponent:i]];
            if (i != self.component - 1) { // 多行用 "," 分割
                [selectString appendString:@","];
            }
        }
        // completion callback
        if (self.completion) {
            self.completion(selectString);
        }
    }
}

- (void)touchBackgroundView{
    if (self.config.isTouchBackgroundHide) {
        [self hide];
    }
}

- (void)show {
    [self.pickerView reloadAllComponents];
    if (_config.isScrollToSelectedRow) {
        [self scrollToSelectedRow];
    } else {
        for (NSUInteger i = 0; i < self.component; i++) {
            [self.pickerView selectRow:0 inComponent:i animated:NO];
        }
    }
    
    // show
    if (_config.isAnimationShow) {
        [[UIApplication sharedApplication].keyWindow addSubview:self];
        
        self.backgroundView.alpha = 0.0f;
        
        CGRect frame = self.contentView.frame;
        frame.origin.y = self.frame.size.height;
        self.contentView.frame = frame;
        
        [UIView animateWithDuration:0.3f animations:^{
            CGRect frame = self.contentView.frame;
            frame.origin.y = self.frame.size.height - self.contentView.frame.size.height;
            self.contentView.frame = frame;
            self.backgroundView.alpha = self.config.backgroundAlpha;
        }];
    } else {
        [UIView animateWithDuration:0.3f animations:^{
            [[UIApplication sharedApplication].keyWindow addSubview:self];
        }];
    }
}

- (void)hide {
    if (self.config.isAnimationShow) {
        CGRect frame = self.contentView.frame;
        frame.origin.y = self.frame.size.height;
        [UIView animateWithDuration:0.3f animations:^{
            self.contentView.frame = frame;
            self.backgroundView.alpha = 0.0f;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
        }];
    } else {
        [UIView animateWithDuration:0.3f animations:^{
            [self removeFromSuperview];
        }];
    }
}

- (NSArray *)getDiffLanguageCanceAndSureBtnTitles{
    NSString *languageName = [[[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"] objectAtIndex:0];
    // 简体中文
    if ([languageName rangeOfString:@"zh-Hans"].location != NSNotFound) {
        return @[@"取消", @"确定"];
    }
    // 繁体中文
    if ([languageName rangeOfString:@"zh-Hant"].location != NSNotFound) {
        return @[@"取消", @"確定"];
    }
    // Other language
    return @[@"Cance", @"Sure"];
}

- (void)scrollToSelectedRow{
    NSString *selectedContent = _config.tipTitle;
    if (selectedContent.length && ![selectedContent isEqualToString:@""]) {
        __weak typeof(self) weakself = self;
        NSMutableArray *tempSelectedRowArray = [NSMutableArray arrayWithCapacity:self.component];
        for (NSUInteger i = 0; i < self.component; i++) {
            NSArray *componentArray = [self getDataWithComponent:i];
            if (componentArray.count) {
                [componentArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    NSString *title = @"";
                    if ([obj isKindOfClass:[NSString class]]) {
                        title = obj;
                    } else if ([obj isKindOfClass:[NSNumber class]]) {
                        title = [NSString stringWithFormat:@"%@", obj];
                    }
                    if (![title isEqualToString:@""]) {
                        NSRange range = [selectedContent rangeOfString:title];
                        if ((self.component == 1 && i == 0) ? ([selectedContent isEqualToString:title]) : (range.location != NSNotFound)) {
                            [tempSelectedRowArray addObject:@(idx)];
                            [weakself.pickerView reloadComponent:i];
                            [weakself.pickerView selectRow:idx inComponent:i animated:NO];
                            [weakself.pickerView reloadComponent:i];
                            *stop = YES;
                        }
                    }
                }];
            }
        }
        
        if (tempSelectedRowArray.count != self.component) {
            for (NSUInteger i = 0; i < self.component; i++) {
                [self.pickerView selectRow:0 inComponent:i animated:NO];
            }
        }
    }
}

- (NSArray *)getDataWithComponent:(NSInteger)component
{
    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:self.dataList];
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSInteger i = 0; i <= component; i++) {
        if (i == component) {
            id data = tempArray.firstObject;
            if ([data isKindOfClass:[NSDictionary class]]) {
                NSMutableArray *tempTitleArray = [NSMutableArray arrayWithArray:tempArray];
                [tempArray removeAllObjects];
                [tempTitleArray enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {
                    [tempArray addObjectsFromArray:dict.allKeys];
                }];
                [arrayM addObjectsFromArray:tempArray];
            } else if ([data isKindOfClass:[NSString class]] ||
                       [data isKindOfClass:[NSNumber class]]){
                [arrayM addObjectsFromArray:tempArray];
            }
        } else {
            NSInteger selectRow = [self.pickerView selectedRowInComponent:i];
            if (selectRow < tempArray.count) {
                id data = tempArray[selectRow];
                if ([data isKindOfClass:[NSDictionary class]]) {
                    [tempArray removeAllObjects];
                    NSDictionary *dict = data;
                    [dict.allValues enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([obj isKindOfClass:[NSArray class]]) {
                            [tempArray addObjectsFromArray:obj];
                        } else {
                            [tempArray addObject:obj];
                        }
                    }];
                }
            }
        }
    }
    return arrayM;
}

#pragma mark - UIPickerView DataSource & Delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return self.component;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self getDataWithComponent:component].count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSArray *componentArray = [self getDataWithComponent:component];
    if (componentArray.count > row) {
        id titleData = componentArray[row];
        if ([titleData isKindOfClass:[NSString class]]) {
            return titleData;
        } else if ([titleData isKindOfClass:[NSNumber class]]) {
            return [NSString stringWithFormat:@"%@", titleData];
        }
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSMutableString *selectString = [[NSMutableString alloc] init];
    
    [pickerView reloadAllComponents];
    for (NSUInteger i = 0; i < self.component; i++) {
        if (i > component) {
            [pickerView selectRow:0 inComponent:i animated:YES];
        }
        
        if (self.config.isShowSelectContent) {
            [selectString appendString:[self pickerView:pickerView titleForRow:[pickerView selectedRowInComponent:i] forComponent:i]];
            if (i == self.component - 1) {
                self.tipLabel.text = selectString;
            }
        }
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return self.config.componetRowHeight;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    if (NO == self.isSettedSelectRowLineBackgroundColor) {
        UIView *topSeparateLine = [pickerView.subviews objectAtIndex:1];
        UIView *bottomSeparateLine = [pickerView.subviews objectAtIndex:2];
        if (topSeparateLine.frame.size.height < 1.0f &&
            bottomSeparateLine.frame.size.height < 1.0f) {
            topSeparateLine.backgroundColor = self.config.selectRowLineBackgroundColor;
            bottomSeparateLine.backgroundColor = self.config.selectRowLineBackgroundColor;
            self.isSettedSelectRowLineBackgroundColor = YES;
        } else {
            for (UIView *singleLine in pickerView.subviews) {
                if (singleLine.frame.size.height < 1.0f) {
                    singleLine.backgroundColor = self.config.selectRowLineBackgroundColor;
                    self.isSettedSelectRowLineBackgroundColor = YES;
                }
            }
        }
    }
    UILabel *pickerLabel = (UILabel *)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.backgroundColor = [UIColor clearColor];
    }
    pickerLabel.attributedText = [self pickerView:pickerView attributedTitleForRow:row forComponent:component];
    
    return pickerLabel;
}

- (nullable NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *normalRowString = [self pickerView:pickerView titleForRow:row forComponent:component];
    NSString *selectRowString = [self pickerView:pickerView titleForRow:[pickerView selectedRowInComponent:component] forComponent:component];
    if (row == [pickerView selectedRowInComponent:component]) {
        return [[NSAttributedString alloc] initWithString:selectRowString attributes:self.config.selectRowTitleAttribute];
    } else {
        return [[NSAttributedString alloc] initWithString:normalRowString attributes:self.config.unSelectRowTitleAttribute];
    }
}


@end
