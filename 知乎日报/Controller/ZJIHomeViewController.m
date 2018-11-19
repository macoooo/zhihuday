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
#import "ZJIDataUtils.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#define HeaderH 200
#define TarBarH 44
#define MinH 64
@interface WSRefreshControl : UIRefreshControl

@end

@implementation WSRefreshControl

-(void)beginRefreshing
{
    [super beginRefreshing];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

-(void)endRefreshing
{
    [super endRefreshing];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}
@end
@interface ZJIHomeViewController ()<UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong)ZJIHomeView *homeView;
@property (nonatomic, strong)ZJIScrollerView *scrollerView;
@property (nonatomic, strong)ZJILeftViewController *leftViewController;
@property (nonatomic, strong)UITapGestureRecognizer *tapToHideLeftMenu;
@property (nonatomic, strong)UIPanGestureRecognizer *pan;
@property (nonatomic, assign)BOOL isLoading;
@end

@implementation ZJIHomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //[self updateLatestNews];
//    NSLog(@"--%ld--", self.homeView.homeModelMutableArray.count);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.flag = 1;
    self.days =  -1;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.07f green:0.51f blue:0.85f alpha:1.00f];
    self.navigationItem.title = @"今日热闻";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"三横-3"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBtnClick)];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]}];

    UIImage *clearImage = [ZJIHomeViewController createImageWithColor:[UIColor clearColor]];
    UIImage *replaceImage = [ZJIHomeViewController imageByApplyingAlpha:0 image:clearImage];
    [self.navigationController.navigationBar setBackgroundImage:replaceImage forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.barStyle = UIBaselineAdjustmentNone;
    
    self.tapToHideSideMenu = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideLeftMenu)];
    self.pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanGesture:)];
    [self.view addGestureRecognizer:self.pan];
    
    _homeView = [[ZJIHomeView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_homeView];
    _homeView.homeModelMutableArray = [NSMutableArray array];
    _homeView.tableView.delegate = self;
    
    UIRefreshControl *refresh = [[WSRefreshControl alloc]init];
    refresh.attributedTitle = [[NSAttributedString alloc]initWithString:@"加载中"];
    [refresh addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refresh;
    [_homeView.tableView addSubview:self.refreshControl];
    
    [self.refreshControl beginRefreshing];
    [self updateLatestNews];
    // Do any additional setup after loading the view.
}
- (void)refresh{
    if(self.refreshControl.isRefreshing){
        [self.homeView.homeModelMutableArray removeAllObjects];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"加载中......"];
        [self addData];
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
        [self.homeView.tableView reloadData];
        [self.refreshControl endRefreshing];
    }
}
- (void)addData{
    [self updateLatestNews];
    NSLog(@"usinging");
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        return 300.0/784 * kHeight;
    }
    return 100.0/784 * kHeight;
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
    return 44.0/784 * kHeight;
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
    UILabel *timeLabel = [[UILabel alloc]init];
    NSString *dateString = [ZJIDataUtils dateStringBeforeDays:1 - section];
    
    timeLabel.text = [NSString stringWithFormat:@"%@ %@",dateString,[self getWeekDayFordate:[ZJIDataUtils dateBeforeDays:1 - section]]];
    timeLabel.textColor = [UIColor whiteColor];
    timeLabel.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headerView).offset(130.0/440 * kWidth);
        make.top.equalTo(headerView).offset(5.0/784 * kHeight);
        make.width.mas_equalTo(kWidth * 0.5);
        make.height.mas_equalTo(44.0/784 * kHeight);
    }];
    return  headerView;
}
- (NSString *)getWeekDayFordate:(NSDate *)date {
    NSArray *weekday = [NSArray arrayWithObjects: [NSNull null], @"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:date];
    
    NSString *weekStr = [weekday objectAtIndex:components.weekday];
    return weekStr;
}

- (void)updateLatestNews
{
    if(self.flag){
    [[ZJIHomeManager sharedManager] fetchHomeDataWithSucceed:^(ZJIHomeModel *homeModel) {
        self->_homeView.homeModel = homeModel;
        self.homeModel = homeModel;
        [self.homeView.homeModelMutableArray addObject:self->_homeView.homeModel];
        self.flag = 0;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.homeView.tableView reloadData];
            [self.homeView fuzhiScrollerImage];
        });
    } error:^(NSError *error) {
        NSLog(@"更新错误");
    }];
    }
    self.isLoading = YES;
    NSLog(@"bbbbbb%ldbbbbb",self.days);
    [[ZJIHomeManager sharedManager] fetchEveryDataWithDate:[ZJIDataUtils dateSecondStringBeforeDays:self.days] Succeed:^(ZJIHomeModel *everyDayHomeModel) {
        self->_homeView.eyeryDayHomeModel = everyDayHomeModel;    [self.homeView.homeModelMutableArray addObject:everyDayHomeModel];
        self.days--;
        self.isLoading = NO;
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.homeView.tableView reloadData];
        });
    } error:^(NSError *error) {
        self.isLoading = NO;
        NSLog(@"更新错误");
    }];
}
- (void)updateEveryPageNews:(NSInteger)id{
    [[ZJIHomeManager sharedManager] fetchEveryPageWithID:id Succeed:^(ZJIEveryPageModel *everyPageModel) {
        self.everyPageModel = everyPageModel;
        [self.everyPageMutableArray addObject:[everyPageModel share_url]];
    } error:^(NSError *error) {
        NSLog(@"更新错误");
    }];
}
- (void)leftBtnClick{
    [self.navigationController.parentViewController performSelector:@selector(openCloseMenu)];
}



- (void)scrollerView:(ZJIScrollerView *)scrollerView indexOfClickedImageBtn:(NSInteger)index
{
    NSLog(@"点击");
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    if(offsetY <= (300.0/784 * kHeight + 100.0/784 * kHeight * self.homeModel.stories.count + 44.0/784 * kHeight - 20)){
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
    CGRect bounds = scrollView.bounds;
    CGSize contentSize = scrollView.contentSize;
    float y = offsetY + bounds.size.height;
    float h = contentSize.height;
    float reload_distance = -30;
    NSLog(@"---%f--y-", y);
    NSLog(@"---%f--h-", h);
    if(y > h + reload_distance){
        if(self.isLoading){
            return;
        }else{
            [self updateLatestNews];
            NSLog(@"using");
        }
    }
}
//创建纯色图片
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
//设置状态栏
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZJIHomeModel *littleModel = self.homeView. homeModelMutableArray[indexPath.section];
    NSInteger transmitID = [littleModel.stories[indexPath.row] sdID];
    NSLog(@"%ld", transmitID);
    [self updateEveryPageNews:transmitID];
    EveryPageViewController *everyPageViewController = [[EveryPageViewController alloc]init];
    everyPageViewController.id = transmitID;
    [self presentViewController:everyPageViewController animated:YES completion:nil];
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
