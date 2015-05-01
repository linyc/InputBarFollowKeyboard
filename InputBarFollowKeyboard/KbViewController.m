//
//  ViewController.m
//  InputBarFollowKeyboard
//
//  Created by CY on 26/1/15.
//  Copyright (c) 2015年 LINYC. All rights reserved.
//

#import "KbViewController.h"
#import "YCInputBar.h"

@interface KbViewController ()
@property (nonatomic,strong) YCInputBar *bar;
@end

@implementation KbViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //注：initBar参数，如果当前有navigationController，那么这里应该传self.navigationController.view
    _bar = [[YCInputBar alloc] initBar:self.view sendButtonTitle:@"发表" maxTextLength:30];
    _bar.placeholder = @"说点什么...";
    _bar.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated{
    if (_bar) {
        [_bar RemoveSelf];
        _bar = nil;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)kbAction:(id)sender {
    [_bar ShowKeyboard];
}
#pragma mark - YCBar delegate
-(BOOL)SendButtonClick:(UITextView *)textView
{
    if (textView.text.length == 0 && ![textView.text containsString:@"\n"]) {
        return NO;
    }
    return YES;
}
-(void)WhenHide
{
    //do something...
}

@end
