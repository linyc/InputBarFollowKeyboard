//
//  UITextViewPlaceholder.m
//  carlive
//
//  Created by CY on 15/4/29.
//  Copyright (c) 2015年 LINYC. All rights reserved.
//

#import "UITextViewPlaceholder.h"

@implementation UITextViewPlaceholder{
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

@end
