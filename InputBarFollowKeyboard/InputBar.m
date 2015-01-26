//
//  InputBar.m
//  InputBarFollowKeyboard
//
//  Created by CY on 26/1/15.
//  Copyright (c) 2015年 LINYC. All rights reserved.
//

#import "InputBar.h"
#define screenRect [UIScreen mainScreen].bounds

@interface InputBar()
    
@property (nonatomic,strong) UIView *viewInputBar;//附加在键盘上方的view
@property (nonatomic,strong) UITextView *txtInput;//输入框
@property (nonatomic,assign) NSInteger maxLength;//最大能输入的字符长度
@property (nonatomic,strong) UIView *bgView;//覆盖整个屏幕
@property (nonatomic,strong) UIButton *hideBtn;//附加到bgView上面的按钮（frame和bgView一样），用来当用户点击bar的其他部分时收起键盘
@property (nonatomic,assign) CGFloat keyboardOriginY;//保存键盘的y坐标
@property (nonatomic,strong) UIButton *btnReply;//send按钮

@property (nonatomic,strong) UIView *MainView;//要附加到的目标view


@end

@implementation InputBar


-(InputBar*)initBar:(UIView *)mainView sendButtonTitle:(NSString *)title maxTextLength:(NSInteger)length
{
    if (self = [super init]) {
        
        self.MainView = mainView;
        self.maxLength = length;
        
        //frame隐藏在屏幕下方
        self.viewInputBar = [[UIView alloc] initWithFrame:CGRectMake(0, screenRect.size.height, screenRect.size.width, 44)];
        self.viewInputBar.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        
        self.txtInput = [[UITextView alloc]  initWithFrame:CGRectMake(8, 8, self.viewInputBar.bounds.size.width-70, 28)];
        self.txtInput.backgroundColor = [UIColor whiteColor];
        //设置该属性，让输入框随父view的尺寸改变而改变
        self.txtInput.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        //边框圆角
        self.txtInput.layer.cornerRadius = 5;
        self.txtInput.layer.borderWidth = 0.8;
        self.txtInput.layer.borderColor = [[UIColor colorWithRed:0.7 green:0.7 blue:0.7 alpha:1] CGColor];
        self.txtInput.delegate=self;
        [self.viewInputBar addSubview:self.txtInput];
        
        self.btnReply = [UIButton buttonWithType:UIButtonTypeSystem];
        self.btnReply.frame = CGRectMake(CGRectGetMaxX(self.txtInput.frame)+8, 8, 46, 28);
        [self.btnReply setTitle:title forState:UIControlStateNormal];
        self.btnReply.enabled=NO;
        [self.btnReply addTarget:self action:@selector(sendBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [self.viewInputBar addSubview:self.btnReply];
        
        [mainView addSubview:self.viewInputBar];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide:) name:UIKeyboardWillHideNotification object:nil];
        

    }
    return self;
}
-(void)ShowKeyboard
{
    [self.txtInput becomeFirstResponder];
}
-(void)sendBtnClick
{
    //主view那边判断完再隐藏键盘
    BOOL b = [self.delegate SendButtonClick:self.txtInput];
    if (b) {
        [self.txtInput resignFirstResponder];
        
        self.txtInput.text = nil;
    }
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *newString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if (newString.length > self.maxLength) {
        return NO;
    }
    self.btnReply.enabled = newString.length > 0;
    return YES;
}
-(void)textViewDidChange:(UITextView *)textView
{
    //让textview随行数自动改变自身的高度
    CGSize txtViewsize = self.txtInput.contentSize;
    if (txtViewsize.height >= 90) {
        return;
    }
    
    CGRect barRect = self.viewInputBar.frame;
    barRect.size.height = txtViewsize.height + 15;
    barRect.origin.y = _keyboardOriginY - barRect.size.height;
    self.viewInputBar.frame = barRect;
}
-(void)keyboardShow:(NSNotification*)notification
{
    NSDictionary *userinfos = [notification userInfo];
    NSValue *val = [userinfos objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect kbRect = [val CGRectValue];
    
    if (_bgView == nil) {
        
        _bgView = [[UIView alloc] initWithFrame:screenRect];
        _bgView.backgroundColor = [UIColor blackColor];
        _bgView.alpha = 0;
        
        _hideBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        _hideBtn.frame = _bgView.frame;
        _hideBtn.backgroundColor = [UIColor clearColor];
        [_hideBtn addTarget:self action:@selector(hideBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_bgView addSubview:_hideBtn];
        
        [self.MainView addSubview:_bgView];
        [self.MainView bringSubviewToFront:_viewInputBar];
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        _bgView.hidden = NO;
        _bgView.alpha = 0.2;
    }];
    
    CGRect inputRect = self.viewInputBar.frame;
    inputRect.origin.y = CGRectGetMinY(kbRect)-inputRect.size.height;
    [self.viewInputBar setFrame:inputRect];
    
    _keyboardOriginY = kbRect.origin.y;
}
-(void)hideBtnClick
{
    [self.txtInput resignFirstResponder];
}
-(void)keyboardHide:(NSNotification*)notification
{
    
    NSDictionary *userinfos = [notification userInfo];
    NSValue *val = [userinfos objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect kbRect = [val CGRectValue];
    
    [UIView animateWithDuration:0.3 animations:^{
        _bgView.alpha = 0;
        _bgView.hidden = YES;
    }];
    
    CGRect inputRect = self.viewInputBar.frame;
    inputRect.origin.y = CGRectGetMinY(kbRect);
    [self.viewInputBar setFrame:inputRect];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

@end
