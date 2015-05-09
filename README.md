# InputBarFollowKeyboard

输入控件，把输入框附加在键盘上方，随键盘出现而出现，随键盘隐藏而隐藏.

（An Input Control that it is adsorb on the keyboard, follow the keyboard 's hide and show.）

![](https://github.com/linyc/InputBarFollowKeyboard/raw/master/show.gif)

#Usage
1. 把这几个文件导入你都项目 （Add these files to your project）

`UITextViewPlaceholder.h`

`UITextViewPlaceholder.m`

`YCInputBar.h`

`YCInputBar.m`

2. 把 `#import "YCInputBar.h"` 加到你要使用的ViewController的头部 （add `#import "YCInputBar.h"` to your ViewController header）

3. 添加代理 `<YCInputBarDelegate>` （add delegate `<YCInputBarDelegate>`）

4. 
``` 
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _bar = [[YCInputBar alloc] initBar:self.view sendButtonTitle:@"发表" maxTextLength:30];
    _bar.placeholder = @"说点什么...";
    _bar.delegate = self;
}

#pragma mark - YCBar delegate
-(BOOL)SendButtonClick:(UITextView *)textView
{
    //如果返回YES，则隐藏键盘并且清空输入的内容，恢复输入框高度，如果返回NO，则不执行
    //if return YES ,the keyboard will hide and clear the inputText,and reset inputbar height, if NO,nothing action.
    if (textView.text.length == 0 && ![textView.text containsString:@"\n"]) {
        return NO;
    }
    return YES;
}
```
#Or use pods
`pod 'InputBarFollowKeyboard', :git => 'https://github.com/linyc/InputBarFollowKeyboard.git'`

#License
[MIT License](http://opensource.org/licenses/MIT).
