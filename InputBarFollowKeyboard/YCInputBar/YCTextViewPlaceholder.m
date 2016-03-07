//
//  UITextViewPlaceholder.m
//  carlive
//
//  Created by CY on 15/4/29.
//  Copyright (c) 2015年 LINYC. All rights reserved.
//

#import "YCTextViewPlaceholder.h"

@implementation YCTextViewPlaceholder{
    UITextView *_placeholderView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _placeholderView = [[UITextView alloc] initWithFrame:CGRectMake(2, 0, frame.size.width-4, frame.size.height-4)];
        _placeholderView.textColor = [UIColor lightGrayColor];
        _placeholderView.editable = NO;
        [self addSubview:_placeholderView];
        [self sendSubviewToBack:_placeholderView];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        _placeholderView = [[UITextView alloc] initWithFrame:CGRectMake(2, 0, self.frame.size.width-4, self.frame.size.height-4)];
        _placeholderView.textColor = [UIColor lightGrayColor];
        _placeholderView.editable = NO;
        [self addSubview:_placeholderView];
        [self sendSubviewToBack:_placeholderView];
        
        //TODO:这种写法不知会不会有问题，请大神指教！！！！
        self.delegate = self;
    }
    return self;
}

-(void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = placeholder;
    _placeholderView.text = placeholder;
}
-(void)setHidePlaceholderView:(BOOL)hidePlaceholderView
{
    _hidePlaceholderView = hidePlaceholderView;
    _placeholderView.hidden = hidePlaceholderView;
}

#pragma mark - textView delegate
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSString *newString = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    //没有输入时显示placeholder文本
    [self setHidePlaceholderView:newString.length > 0];
    return YES;
}
@end
