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
    
@property (nonatomic,strong) UIView *viewInputBar;
@property (nonatomic,strong) UITextView *txtInput;
@property (nonatomic,assign) NSInteger maxLength;
@property (nonatomic,strong) UIView *bgView;
@property (nonatomic,assign) CGFloat keyboardOriginY;
@property (nonatomic,strong) UIButton *hideBtn;
@property (nonatomic,strong) UIButton *btnReply;

@property (nonatomic,strong) UIView *MainView;


@end

@implementation InputBar


-(InputBar*)initBar:(UIView *)mainView sendButtonTitle:(NSString *)title maxTextLength:(NSInteger)length
{
    if (self = [super init]) {
        
        self.MainView = mainView;
        self.maxLength = length;
        
        self.viewInputBar = [[UIView alloc] initWithFrame:CGRectMake(0, screenRect.size.height, screenRect.size.width, 44)];
        self.viewInputBar.backgroundColor=[UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
        
        self.txtInput = [[UITextView alloc]  initWithFrame:CGRectMake(8, 8, self.viewInputBar.bounds.size.width-70, 28)];
        self.txtInput.backgroundColor = [UIColor whiteColor];
        self.txtInput.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
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
    BOOL b = [self.delegate SendButtonClick:self.txtInput];
    if (b) {
        [self.txtInput resignFirstResponder];
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
    
    self.txtInput.text = nil;
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
