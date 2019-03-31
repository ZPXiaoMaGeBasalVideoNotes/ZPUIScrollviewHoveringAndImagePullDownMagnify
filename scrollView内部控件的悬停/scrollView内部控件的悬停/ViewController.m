//
//  ViewController.m
//  scrollView内部控件的悬停
//
//  Created by apple on 2017/1/9.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UIView *redView;

@end

@implementation ViewController

#pragma mark ————— 生命周期 —————
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.scrollView.contentSize = CGSizeMake(0, CGRectGetMaxY(self.blueView.frame));
}

#pragma mark ————— UIScrollViewDelegate —————
//scrollView控件滚动的时候系统就会不停地调用此方法，所以一般用此方法来监听scrollView控件的滚动。
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat imageHeight = self.imageView.frame.size.height;
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY >= imageHeight)  //当scrollView控件向上滚动的时候，图片会慢慢地消失，直至图片完全推到屏幕以外，即scrollView控件的offsetY的值大于或者等于imageHeight的值，这个时候想让redView悬停在屏幕的顶部，不随着scrollView控件的滚动而继续滚动。
    {
        CGRect redFrame = self.redView.frame;  //OC语法不允许对结构体的某个属性直接赋值
        redFrame.origin.y = 0;
        self.redView.frame = redFrame;
        
        [self.view addSubview:self.redView];  //把redView直接加在self.redView上
    }else  //当scrollView控件向下滚动的时候，图片会慢慢地显示到屏幕上，即scrollView控件的offsetY的值小于imageHeight的值，这个时候再把redView添加到scrollView控件上，让它随着scrollView控件一起滚动。
    {
        CGRect redFrame = self.redView.frame;
        redFrame.origin.y = 120;  //设置redView的y值为一开始图片的高度
        self.redView.frame = redFrame;
        
        [self.scrollView addSubview:self.redView];  //把redView加在scrollView控件上
    }
    
    //scrollView控件下拉图片放大动画
    if (offsetY < 0)
    {
        CGFloat scale = 1 - (offsetY / 50);
        self.imageView.transform = CGAffineTransformMakeScale(scale, scale);
    }
}

@end
