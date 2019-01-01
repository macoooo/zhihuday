//
//  ZJIHomeView.m
//  知乎日报
//
//  Created by 强淑婷 on 2018/10/28.
//  Copyright © 2018年 强淑婷. All rights reserved.
//

#import "ZJIHomeView.h"
#import "ZJIStoriesTableViewCell.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
@interface ZJIHomeView()
@property (nonatomic,strong)dispatch_queue_t queue;
@end

@implementation ZJIHomeView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self){
        _homeModel = [[ZJIHomeModel alloc]init];
        self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
        
        [self.tableView registerClass:[ZJIStoriesTableViewCell class] forCellReuseIdentifier:@"storiesCell"];
        
        self.tableView.dataSource = self;
        self.tableView.contentInsetAdjustmentBehavior = UIApplicationBackgroundFetchIntervalNever;
        [self addSubview:_tableView];
        self.backgroundColor = [UIColor whiteColor];
        
        self.queue = dispatch_queue_create("sf", NULL);
       
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
        return 1;
    }
    if(_latestNewsCacheModel){
        return _latestNewsCacheModel.stories.count;
    } else {
        ZJIHomeModel *homeModel = self.homeModelMutableArray[section - 1];
        return homeModel.stories.count;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"--%ld--self.homeModelMutableArray.count-", self.homeModelMutableArray.count);
    if(_latestNewsCacheModel){
        return 2;
    }
    return self.homeModelMutableArray.count + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"cell0"];
        if(!cell){
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell0"];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            _scrollerView = [[ZJIScrollerView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300.0/784 * kHeight)];
            _scrollerView.delegate = self;
            _scrollerView.currentPageColor = [UIColor orangeColor];
            _scrollerView.pageColor = [UIColor grayColor];
            [cell.contentView addSubview:_scrollerView];
        }
        return cell;
    }else{
        ZJIStoriesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: @"storiesCell" forIndexPath:indexPath];
        if(!cell){
            cell = [[ZJIStoriesTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"storiesCell"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.section == 1 && _latestNewsCacheModel) {
            cell.titleLabel.text = [_latestNewsCacheModel.stories[indexPath.row] title];
            NSArray *imageArray = [_latestNewsCacheModel.stories[indexPath.row] images];
            [cell.storiesImageView  sd_setImageWithURL:[NSURL URLWithString:imageArray[0]]];
        } else {
            ZJIHomeModel *smallModel = self.homeModelMutableArray[indexPath.section - 1];
            NSArray *storiesArray = [smallModel.stories[indexPath.row] images];
            NSString *imageString = storiesArray[0];
            dispatch_async(self.queue, ^{
                [cell.storiesImageView  sd_setImageWithURL:[NSURL URLWithString:imageString]];
            });
            cell.titleLabel.text = [smallModel.stories[indexPath.row] title];
        }
        return cell;
    }
}
- (void)fuzhiScrollerImage
{
    NSMutableArray *topStoriesArray = [NSMutableArray array];
    NSArray *topStoryArray = [NSArray array];
    if(self.latestNewsCacheModel){
        topStoryArray = self.imageDataArray;
    }else{
        topStoryArray = self.homeModel.top_stories;
    }
    
    //NSMutableArray *imageDataArray = [NSMutableArray array];
    NSLog(@"---%ld--topStoryArray.count-", topStoryArray.count);
    for(int i = 0;i < topStoryArray.count;i++){
        [topStoriesArray addObject:[UIImage imageWithData:_imageDataArray[i]]];
    }
    
    _scrollerView.images = [NSArray arrayWithArray:topStoriesArray];
}
- (UIImage *)getImageFromURL:(NSString *)fileURL{
    UIImage *result;
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:fileURL]];
    result = [UIImage imageWithData:data];
    return result;
}
+ (UIImage *)getImageFromData:(NSData *)data{
    UIImage *image = [UIImage imageWithData:data];
    return image;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
