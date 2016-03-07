//
//  InputBar.h
//  InputBarFollowKeyboard
//
//  Created by CY on 26/1/15.
//  Copyright (c) 2015年 LINYC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YCTextViewPlaceholder.h"
@class YCInputBar;
@protocol YCInputBarDelegate <NSObject>

@required
/**
 *  点击发送按钮后执行
 *
 *  @param textView 将当前文本框控件传给实现了委托方法的对象
 *
 *  @return 委托执行后返回一个BOOL值(YES:隐藏键盘；NO:不隐藏键盘)来决定是否要隐藏键盘，同时键盘隐藏后要做的事（执行whenHide）
 */
-(BOOL)sendButtonClick:(UITextView*)textView;

@optional
//输入框隐藏的时候要做的事
-(void)whenHide;

@end

@interface YCInputBar : NSObject<UITextViewDelegate>
/**
 *  初始化控件，默认隐藏在界面下方
 *
 *  @param mainView 要附加到的view（如果当前有navigationController，那么这里应该传self.navigationController.view）
 *  @param title    按钮的文字
 *  @param length   限制最大输入长度
 *  @param isHide   是否将输入框隐藏在view的下方
 *  @param color    发送按钮的颜色（传nil表示默认）
 *
 *  @return 返回当前控件实例，
 */
-(YCInputBar*)initBar:(UIView*)mainView sendButtonTitle:(NSString*)title maxTextLength:(NSInteger)length isHideOnBottom:(BOOL)isHide buttonColor:(UIColor*)color;

/**
 *  调用键盘
 */
-(void)showKeyboard;

/**
 *  由于目前只是隐藏键盘，实际上没有移除，还占用内存，所以当不需要的时候（比如pop掉当前界面时）调用此方法进行移除
 */
-(void)removeSelf;

@property (nonatomic,strong) id <YCInputBarDelegate> delegate;

/**
 *  默认显示的字符
 */
@property (nonatomic,copy) NSString *placeholder;
@end
