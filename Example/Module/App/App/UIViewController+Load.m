//Created  on 2019/9/17 by  LCD:https://github.com/liucaide .

/***** 模块文档 *****
 *
 */





#import "CaamDau_Example-Swift.h"

@implementation UIViewController (Load)
    
+ (void)load {
    [UIViewController cd_methodSwizzling];
}

/*
- (UIModalPresentationStyle)modalPresentationStyle {
    
    return UIModalPresentationFullScreen;
}*/
    
@end
