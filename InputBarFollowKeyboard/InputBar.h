//
//  InputBar.h
//  InputBarFollowKeyboard
//
//  Created by CY on 26/1/15.
//  Copyright (c) 2015年 LINYC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class InputBar;
@protocol InputBarDelegate <NSObject>

@required
-(BOOL)SendButtonClick:(UITextView*)textView;

@end

@interface InputBar : NSObject<UITextViewDelegate>
-(InputBar*)initBar:(UIView*)mainView sendButtonTitle:(NSString*)title maxTextLength:(NSInteger)length;
-(void)ShowKeyboard;

@property (nonatomic,strong) id <InputBarDelegate> delegate;
@end
