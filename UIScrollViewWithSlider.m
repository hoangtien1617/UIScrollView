//
//  UIScrollViewWithSlider.m
//  UIScrollView
//
//  Created by Hoàng Tiến on 11/17/15.
//  Copyright © 2015 Hoàng Tiến. All rights reserved.
//

#import "UIScrollViewWithSlider.h"

@interface UIScrollViewWithSlider ()<UIScrollViewDelegate>
@property (strong,nonatomic) UIScrollView *scrollView;
@end

@implementation UIScrollViewWithSlider
{
    UIImageView *image;
    UIToolbar *toolbar;
    UISlider *slider;
}

- (void)viewDidLoad {
        [super viewDidLoad];
        self.view.backgroundColor  = [UIColor whiteColor];
    //Add toolBar
    toolbar = [UIToolbar new];
    [toolbar sizeToFit]; // chỉnh bounds
    slider = [[UISlider alloc]   initWithFrame:CGRectMake(8, 0, self.view.bounds.size.width -16, 40)];
    slider.minimumValue = 0.2;
    slider.maximumValue = 5.0;
    slider.value = slider.minimumValue;
    [slider addTarget:self action:@selector(onSliderChange:) forControlEvents:UIControlEventValueChanged];
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithCustomView:slider];
    toolbar.items = @[barButton];
    toolbar.frame = CGRectMake(0,toolbar.bounds.size.height + 20, toolbar.bounds.size.width, toolbar.bounds.size.height);
    [self.view addSubview:toolbar];
    CGRect scrollRect = CGRectMake(0, toolbar.bounds.size.height*2 +20, self.view.bounds.size.width, self.view.bounds.size.height - toolbar.bounds.size.height);
    self.scrollView = [[UIScrollView alloc]initWithFrame:scrollRect ];
    image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HD.jpg"]];
    [self.scrollView addSubview:image];
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = slider.minimumValue;
    self.scrollView.maximumZoomScale = slider.maximumValue;
    self.scrollView.zoomScale = slider.value;
    [self.view addSubview:self.scrollView];

}

-(void) onSliderChange :(UISlider *) sender {
    [self.scrollView setZoomScale:sender.value
                         animated:true];
}
-(nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return image;
}
- (void)scrollViewDidZoom:(UIScrollView *)scrollView{
    slider.value = self.scrollView.zoomScale  ;
}


@end
