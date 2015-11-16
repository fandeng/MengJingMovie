

/**
 *******************************************************
 *                                                      *
 * 感谢您的支持， 如果下载的代码在使用过程中出现BUG或者其他问题    *
 * 您可以发邮件到 asiosldh@163.com 或者 到                       * 在别人代码上修改一下
 * http://www.cocoachina.com/bbs/              提交问题     *
 *
 * 1.暂时只是有显示网络图片
 * 2.
 *
 *******************************************************
 */


#import <UIKit/UIKit.h>

@protocol DJPageViewDelegate <NSObject>

- (void)DJPageViewscrollViewDidEndDecelerating:(UIScrollView *)scrollView;

@end


@interface DJPageView : UIView

@property(nonatomic, weak)id<DJPageViewDelegate> delegate;

/**
 * 时间time
 */
@property (nonatomic ,assign) NSTimeInterval duration;
/**
 * PageControl 的背景颜色
 */
@property (nonatomic,strong) UIColor *pageBackgroundColor;
/**
 * PageControl 在普通状态下的颜色
 */
@property (nonatomic,strong) UIColor *pageIndicatorTintColor;
/**
 * PageControl 选中状态的颜色
 */
@property (nonatomic,strong) UIColor *currentPageColor;


/**
 *  frame 尺寸 webimages网络图片http链接arr action 点击了xx页的的回调blocks
 */
- (instancetype)initPageViewFrame:(CGRect)frame
                      webImageStr:(NSArray *)webimages
          didSelectPageViewAction:( void(^)(NSInteger index ))action;
@end
