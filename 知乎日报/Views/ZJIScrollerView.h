//
//  ZJIScrollerView.h
//  
//
//  Created by 强淑婷 on 2018/10/25.
//

#import <UIKit/UIKit.h>

@class ZJIScrollerView;
@protocol ZJIScrollerViewDelegate <NSObject>
@optional
//点击图片的回调事件
- (void)scrollerView:(ZJIScrollerView *)scrollerView indexOfClickedImageBtn:(NSInteger)index;
@end


@interface ZJIScrollerView : UIView
//传入图片数组
@property (nonatomic, copy)NSArray *images;
@property (nonatomic, strong)UIColor *currentPageColor;
@property (nonatomic, strong)UIColor *pageColor;
@property (nonatomic, copy)NSArray *title;
//是否竖向滚动
@property (nonatomic, assign, getter=isScrollDorectionPortrait) BOOL scrollDorectionPortrait;
@property (weak, nonatomic)id <ZJIScrollerViewDelegate>delegate;
@end
