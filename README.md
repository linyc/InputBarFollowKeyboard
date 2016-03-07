# InputBarFollowKeyboard

输入控件，把输入框附加在键盘上方，随键盘出现而出现，随键盘隐藏而隐藏.


![](https://github.com/linyc/InputBarFollowKeyboard/raw/master/show.gif)

#如何使用
1、 把文件夹｀YCInputBar｀拖入你的项目，包含以下4个文件

`YCTextViewPlaceholder.h`

`YCTextViewPlaceholder.m`

`YCInputBar.h`

`YCInputBar.m`

2、 把 `#import "YCInputBar.h"` 加到你要使用的ViewController的头部

3、 添加代理 `<YCInputBarDelegate>`

4、 添加一个属性 `@property (nonatomic,strong) YCInputBar *bar;` 
``` 
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bar = [[YCInputBar alloc] initBar:self.view sendButtonTitle:@"评论" maxTextLength:30 isHideOnBottom:YES buttonColor:nil];
    _bar.placeholder = @"说点什么...";
    _bar.delegate = self;
}

#pragma mark - YCBar delegate
-(BOOL)sendButtonClick:(UITextView *)textView
{
    //如果返回YES，则隐藏键盘并且清空输入的内容，恢复输入框高度，如果返回NO，则不执行
    if (textView.text.length == 0 && ![textView.text containsString:@"\n"]) {
        return NO;
    }

    NSLog(@"你的评论：%@",textView.text);

    return YES;
}
//可选，当键盘收起时要处理的事务
-(void)whenHide
{
    NSLog(@"收起键盘");
}
```
#或者使用 pod 进行导入
`pod 'InputBarFollowKeyboard', :git => 'https://github.com/linyc/InputBarFollowKeyboard.git'`

#License
[MIT License](http://opensource.org/licenses/MIT).


---

# InputBarFollowKeyboard

An Input Control that it is adsorb on the keyboard, follow the keyboard 's hide and show.

![](https://github.com/linyc/InputBarFollowKeyboard/raw/master/show.gif)

#Usage
1、 Add the folder of `YCInputBar` to your project,it's include 4 file

`YCTextViewPlaceholder.h`

`YCTextViewPlaceholder.m`

`YCInputBar.h`

`YCInputBar.m`

2、 add `#import "YCInputBar.h"` to your ViewController header

3、 add delegate `<YCInputBarDelegate>`

4、 add property `@property (nonatomic,strong) YCInputBar *bar;` 
``` 
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bar = [[YCInputBar alloc] initBar:self.view sendButtonTitle:@"Send" maxTextLength:30 isHideOnBottom:YES buttonColor:nil];
    _bar.placeholder = @"say something...";
    _bar.delegate = self;
}

#pragma mark - YCBar delegate
-(BOOL)sendButtonClick:(UITextView *)textView
{
    //if return YES ,the keyboard will hide and clear the inputText,and reset inputbar height, if NO,nothing action.
    if (textView.text.length == 0 && ![textView.text containsString:@"\n"]) {
        return NO;
    }

    NSLog(@"your input text：%@",textView.text);

    return YES;
}
//option,you can do something when the keyboard hide
-(void)whenHide
{
    NSLog(@"hide keyboard");
}
```
#Or use pods
`pod 'InputBarFollowKeyboard', :git => 'https://github.com/linyc/InputBarFollowKeyboard.git'`

#License
[MIT License](http://opensource.org/licenses/MIT).


