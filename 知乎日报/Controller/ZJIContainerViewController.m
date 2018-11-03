//
//  ZJIContainerViewController.m
//  知乎日报
//
//  Created by 强淑婷 on 2018/11/2.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "ZJIContainerViewController.h"
#import "ZJILeftViewController.h"
#import "ZJIHomeViewController.h"
#define kWidth self.view.bounds.size.width
#define kHeight self.view.bounds.size.height

@interface ZJIContainerViewController ()<UITableViewDelegate>

@property (nonatomic, strong)ZJILeftViewController *leftViewController;
//用来存放和记录当前呈现的主控制器界面
@property (nonatomic, strong)UIViewController *contentController;
@property (nonatomic, strong)NSArray *viewControllers;
@property (nonatomic, assign, readonly)BOOL isMenuOpen;
@property (nonatomic, assign)NSUInteger controllerIndex;
@property (nonatomic, assign, readonly)BOOL isAnimating;

@end

@implementation ZJIContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addMenuViewController];
    [self addContentControllers];
    // Do any additional setup after loading the view.
}
- (void)addMenuViewController{
    [self setLeftViewController:[[ZJILeftViewController alloc]init]];
    [self addChildViewController:self.leftViewController];
    [self.view addSubview:self.leftViewController.view];
    self.leftViewController.leftView.tableView.delegate = self;
}
- (void)addContentControllers
{
    ZJIHomeViewController *homeViewController = [[ZJIHomeViewController alloc]init];
    UINavigationController *navHomeViewController = [[UINavigationController alloc]initWithRootViewController:homeViewController];
    [self setViewControllers:@[navHomeViewController]];
    [self setContentController:navHomeViewController];
}
- (void)setContentController:(UIViewController *)contentController{
    if(_contentController == contentController){
        return;
    }
    //内容控制器起始坐标不一致
    if(_contentController){
        contentController.view.transform = _contentController.view.transform;
    }
    [_contentController willMoveToParentViewController:nil];
    [_contentController.view removeFromSuperview];
    [_contentController removeFromParentViewController];
    
    _contentController = contentController;
    [self addChildViewController:contentController];
    [self.view addSubview:contentController.view];
    
}
- (void)openCloseMenu
{
    
    if (_isAnimating) {
        return;
    }
    [UIView animateWithDuration:0.2 animations:^{
        self->_isAnimating = YES;
        if(!self->_isMenuOpen){
            self.contentController.view.transform = CGAffineTransformMakeTranslation(kWidth/2, 0);
            self.leftViewController.view.transform = CGAffineTransformMakeTranslation(kWidth/2, 0);
        }
        else {
            self.contentController.view.transform = CGAffineTransformMakeTranslation(0, 0);
            self.leftViewController.view.transform = CGAffineTransformMakeTranslation(-kWidth/2, 0);
        }
    }completion:^(BOOL finished) {
        self->_isMenuOpen = !self->_isMenuOpen;
        [self setContentController:self.viewControllers[self.controllerIndex]];
        if (!self->_isMenuOpen ) {
            self->_isAnimating = NO;
                       [UIView animateWithDuration:0.2 delay:0.1 options:UIViewAnimationOptionCurveEaseIn  animations:^{
                           self.contentController.view.transform = CGAffineTransformIdentity;
                       } completion:^(BOOL finished) {
                           self->_isAnimating = NO;
                       }];
        }
        else {
            self->_isAnimating = NO;
        }
        
    }];
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self openCloseMenu];
    [self setContentController:_viewControllers[indexPath.row]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
