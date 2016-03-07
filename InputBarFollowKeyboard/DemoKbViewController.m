//
//  ViewController.m
//  InputBarFollowKeyboard
//
//  Created by CY on 26/1/15.
//  Copyright (c) 2015年 LINYC. All rights reserved.
//

#import "DemoKbViewController.h"
#import "YCInputBar.h"

@interface DemoKbViewController ()
@property (nonatomic,strong) YCInputBar *bar;
@end

@implementation DemoKbViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //注：initBar参数，如果当前有navigationController，那么这里应该传self.navigationController.view
    _bar = [[YCInputBar alloc] initBar:self.view sendButtonTitle:@"评论" maxTextLength:30 isHideOnBottom:YES buttonColor:nil];
    _bar.placeholder = @"说点什么...";
    _bar.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated{
    if (_bar) {
        [_bar removeSelf];
        _bar = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)kbAction:(id)sender {
    [_bar showKeyboard];
}
#pragma mark - YCBar delegate
-(BOOL)sendButtonClick:(UITextView *)textView
{
    if (textView.text.length == 0 && ![textView.text containsString:@"\n"]) {
        return NO;
    }
    
    NSLog(@"你的评论：%@",textView.text);
    
    return YES;
}
-(void)whenHide
{
    NSLog(@"收起键盘");
}

@end
