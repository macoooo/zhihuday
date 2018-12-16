//
//  ZJIScrollerView.m
//  
//
//  Created by 强淑婷 on 2018/10/25.
//

#import "ZJIScrollerView.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height

static const int imageBtnCount = 3;
@interface ZJIScrollerView ()<UIScrollViewDelegate>

@property (nonatomic, weak)UIScrollView *scrollerView;
@property (nonatomic, weak)UIPageControl *pageControl;
@property (nonatomic, weak)NSTimer *timer;
@end
@implementation ZJIScrollerView

- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        UIScrollView *scrollerView = [[UIScrollView alloc]init];
        scrollerView.delegate = self;
        //横竖两种滚轮都不显示
        scrollerView.showsVerticalScrollIndicator = NO;
        scrollerView.showsHorizontalScrollIndicator = NO;
        scrollerView.pagingEnabled = YES;
        scrollerView.bounces = NO;
        [self addSubview:scrollerView];
        self.scrollerView = scrollerView;
        
        for(int i = 0;i < imageBtnCount;i++){
            UIButton *imageBtn = [[UIButton alloc]init];
            [scrollerView addSubview:imageBtn];
        }
        UIPageControl *pageControl = [[UIPageControl alloc]init];
        [self addSubview:pageControl];
        self.pageControl = pageControl;
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.scrollerView.frame = self.bounds;
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    //设置contentSize,不同轮播方向的时候contentSize是不一样的
    if(self.isScrollDorectionPortrait){
        self.scrollerView.contentSize = CGSizeMake(width, height * imageBtnCount);
    }
    else{
        self.scrollerView.contentSize = CGSizeMake(width * imageBtnCount, height);
    }
    //设置三张图片的位置，并为三个按钮添加点击事件
    for(int i = 0;i < imageBtnCount;i++){
        UIButton *imageBtn = self.scrollerView.subviews[i];
        [imageBtn addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        if(self.isScrollDorectionPortrait){
            imageBtn.frame = CGRectMake(0, i * height, width, height);
        }else{
            imageBtn.frame = CGRectMake(i * width, 0, width, height);
        }
    }
    //设置contentOffSet,显示最中间的图片
    if(self.isScrollDorectionPortrait){
        self.scrollerView.contentOffset = CGPointMake(0, height);
    }else{
        self.scrollerView.contentOffset = CGPointMake(width, 0);
    }
    CGFloat pageW = 100;
    CGFloat pageH = 20;
    CGFloat pageX = width - pageW;
    CGFloat pageY = height - pageH;
    self.pageControl.frame = CGRectMake(pageX, pageY, pageW, pageH);
    
}

//设置pageControl的CurrentPageColor
- (void)setCurrentPageColor:(UIColor *)currentPageColor{
    _currentPageColor = currentPageColor;
    self.pageControl.currentPageIndicatorTintColor = currentPageColor;
}
//设置pageControl的pageColor
- (void)setPageColor:(UIColor *)pageColor{
    _pageColor = pageColor;
    self.pageControl.pageIndicatorTintColor = pageColor;
}

//根据传入的图片数组设置图片
- (void)setImages:(NSArray *)images{
    _images = images;
    self.pageControl.numberOfPages = images.count;
    self.pageControl.currentPage = 0;
    [self setContent];
    [self startTimer];
}
//- (void)setTitle:(NSArray *)title{
//    _title = title;
//    self.pageControl.numberOfPages = title.count;
//    self.pageControl.currentPage = 0;
//    [self setContent];
//    [self startTimer];
//}
//设置显示内容
- (void)setContent{
    //设置三个imageBtn的图片
    for(int i = 0;i < self.scrollerView.subviews.count;i++){
        //取出三个imageBtn
        UIButton *imageBtn = self.scrollerView.subviews[i];
        //这个是为了给图片做索引用的
        NSInteger index = self.pageControl.currentPage;
        
        if(i == 0){//第一个imageBtn，隐藏在当前显示的imageBtn的左侧
            index--;//当前页索引减1就是第一个imageBtn的图片索引
        }else if (i == 2){
            index++;
        }
        if(index < 0){
            index = self.pageControl.numberOfPages - 1;
        }else if (index == self.pageControl.numberOfPages){
            index = 0;
        }
        imageBtn.tag = index;
        [imageBtn setBackgroundImage:self.images[index] forState:UIControlStateNormal];
        [imageBtn setBackgroundImage:self.images[index] forState:UIControlStateNormal];
    }
}
- (void)updateContent{
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.bounds.size.height;
    [self setContent];
    
    if(self.isScrollDorectionPortrait){
        self.scrollerView.contentOffset = CGPointMake(0, height);
    }else{
        self.scrollerView.contentOffset = CGPointMake(width, 0);
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = 0;
    CGFloat minDistance = MAXFLOAT;
    for(int i = 0;i < self.scrollerView.subviews.count; i++){
        UIButton *imageBtn = self.scrollerView.subviews[i];
        CGFloat distance = 0;
        if(self.isScrollDorectionPortrait){
            distance = ABS(imageBtn.frame.origin.y - scrollView.contentOffset.y);
        }else{
            distance = ABS(imageBtn.frame.origin.x - scrollView.contentOffset.x);
        }
        if(distance < minDistance){
            minDistance = distance;
            page = imageBtn.tag;
        }
    }
    self.pageControl.currentPage = page;
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self startTimer];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [self updateContent];
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self updateContent];
}




- (void)startTimer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}
- (void)stopTimer{
    [self.timer invalidate];
    self.timer = nil;
}
-(void)nextImage{
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    if(self.isScrollDorectionPortrait){
        [self.scrollerView setContentOffset:CGPointMake(0, 2 * height) animated:YES];
    }else{
        [self.scrollerView setContentOffset:CGPointMake(2 * width, 0) animated:YES];
    }
}
- (void)imageBtnClick:(UIButton *)btn{
    if([self.delegate respondsToSelector:@selector(scrollerView:indexOfClickedImageBtn:)]){
        [self.delegate scrollerView:self indexOfClickedImageBtn:btn.tag];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
