//
//  ViewController.m
//  InputBarFollowKeyboard
//
//  Created by CY on 26/1/15.
//  Copyright (c) 2015年 LINYC. All rights reserved.
//

#import "KbViewController.h"
#import "InputBar.h"

@interface KbViewController ()
@property (nonatomic,strong) InputBar *bar;
@end

@implementation KbViewController

- (void)viewDidLoad {
    [super viewDidLoad];
// Do any additional setup after loading the view, typically from a nib.
    _bar = [[InputBar alloc] initBar:self.view sendButtonTitle:@"发表" maxTextLength:10];
    _bar.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)kbAction:(id)sender {
    [_bar ShowKeyboard];
}

-(BOOL)SendButtonClick:(UITextView *)textView
{
    if (textView.text.length == 0 && ![textView.text containsString:@"\n"]) {
        return NO;
    }
    return YES;
}

@end
