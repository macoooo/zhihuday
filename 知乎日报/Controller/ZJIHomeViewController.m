//
//  ZJIHomeViewController.m
//  知乎日报
//
//  Created by 强淑婷 on 2018/10/22.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "ZJIHomeViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "ZJIHomeView.h"
#import "ZJILeftViewController.h"

#define kWidth self.view.bounds.size.width
#define kHeight self.view.bounds.size.height
#define HeaderH 200
#define TarBarH 44
#define MinH 64
@interface ZJIHomeViewController ()<UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong)ZJIHomeView *homeView;
@property (nonatomic, strong)ZJIScrollerView *scrollerView;
@property (nonatomic, assign)CGFloat oriOffsetY;
@property (nonatomic, strong)ZJILeftViewController *leftViewController;
@property (nonatomic, strong)UITapGestureRecognizer *tapToHideLeftMenu;
@property (nonatomic, strong)UIPanGestureRecognizer *pan;
@end

@implementation ZJIHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.07f green:0.51f blue:0.85f alpha:1.00f];
    self.navigationItem.title = @"今日热闻";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"三横-3"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]}];

    UIImage *clearImage = [ZJIHomeViewController createImageWithColor:[UIColor clearColor]];
    UIImage *replaceImage = [ZJIHomeViewController imageByApplyingAlpha:0 image:clearImage];
    [self.navigationController.navigationBar setBackgroundImage:replaceImage forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;
    
    self.tapToHideLeftMenu = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideLeftMenu)];
    self.pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:self.pan];
    //添加双击手势
//    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTap:)];
//    [doubleTap setNumberOfTapsRequired:2];
//    [self.view addGestureRecognizer:doubleTap];
//
//    //添加两个手指双击手势
//    UITapGestureRecognizer *twoFingerDoubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(twoFingerDoubleTap:)];
//    [twoFingerDoubleTap setNumberOfTapsRequired:2];
//    [twoFingerDoubleTap setNumberOfTouchesRequired:2];
//    [self.view addGestureRecognizer:twoFingerDoubleTap];
//
    _homeView = [[ZJIHomeView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_homeView];
    _homeView.tableView.delegate = self;
    
    // Do any additional setup after loading the view.
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        return 300.0/784 * kHeight;
    }
    return 50;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [[UIView alloc]init];
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0 || section == 1){
        return 0;
    }
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return nil;
    }
    if(section == 1){
        return nil;
    }
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = [UIColor colorWithRed:0.07f green:0.51f blue:0.85f alpha:1.00f];
    UILabel *timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 0, 200, 64)];
    timeLabel.text = @"2018年9月1日";
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:timeLabel];
    return  headerView;
}
- (void)leftBtnClick{
    [self.navigationController.parentViewController performSelector:@selector(openCloseMenu)];
}
- (void)doubleTap:(UITapGestureRecognizer *)gesture
{
    [self.mm_drawerController bouncePreviewForDrawerSide:MMDrawerSideLeft completion:nil];
}
- (void)twoFingerDoubleTap:(UITapGestureRecognizer *)gesture{
    [self.mm_drawerController bouncePreviewForDrawerSide:MMDrawerSideLeft completion:nil];
}
- (void)scrollerView:(ZJIScrollerView *)scrollerView indexOfClickedImageBtn:(NSInteger)index
{
    NSLog(@"点击");
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY <= (300.0/784 * kHeight + 500)){
        UIImage *gradualChangeImage = [ZJIHomeViewController createImageWithColor:[UIColor colorWithRed:0.07f green:0.51f blue:0.85f alpha:1.00f]];
        UIImage *replaceImage = [ZJIHomeViewController imageByApplyingAlpha:offsetY/300.0/784 * kHeight image:gradualChangeImage];
        [self.navigationController.navigationBar setBackgroundImage:replaceImage forBarMetrics:UIBarMetricsDefault];
        self.navigationController.navigationBar.hidden = NO;
        [self setStatusBarBackgroundColor:[UIColor clearColor]];
        self.homeView.tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    else{
        self.homeView.tableView.contentInset = UIEdgeInsetsMake(20, 0, 0, 0);
        [self setStatusBarBackgroundColor:[UIColor colorWithRed:0.07f green:0.51f blue:0.85f alpha:1.00f]];
        self.navigationController.navigationBar.hidden = YES;
    }
    
}
+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect=CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
//设置图片透明度

+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image
{
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0f);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGRect area = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CGContextScaleCTM(ctx, 1, -1);
    
    CGContextTranslateCTM(ctx, 0, -area.size.height);
    
    CGContextSetBlendMode(ctx, kCGBlendModeMultiply);
    
    CGContextSetAlpha(ctx, alpha);
    
    CGContextDrawImage(ctx, area, image.CGImage);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return newImage;
}
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self setStatusBarBackgroundColor:[UIColor colorWithRed:0.07f green:0.51f blue:0.85f alpha:1.00f]];
    return YES;
}

- (void)setStatusBarBackgroundColor:(UIColor *)color {
    
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = color;
    }
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
