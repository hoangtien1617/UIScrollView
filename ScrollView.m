//
//  ScrollView.m
//  UIScrollView
//
//  Created by Hoàng Tiến on 11/17/15.
//  Copyright © 2015 Hoàng Tiến. All rights reserved.
//

#import "ScrollView.h"

@interface ScrollView () <UIScrollViewDelegate>
@property (strong,nonatomic) UIScrollView *scrollView;
@property (nonatomic, strong) NSString* about;
@property (strong,nonatomic) UILabel *label;

@end

@implementation ScrollView
{
    UIImageView *image;
    NSTimer *timer;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor whiteColor];
    self.scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds ];
    image = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HD.jpg"]];
    [self.scrollView addSubview:image];
    self.scrollView.delegate = self;
    self.scrollView.minimumZoomScale = 0.2;
    self.scrollView.maximumZoomScale = 4.0;
    self.scrollView.zoomScale = 0.2;
    [self.view addSubview:self.scrollView];
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0.0 , 0.0, self.view.frame.size.width/3, 20)];
    [self.label setBackgroundColor:[UIColor clearColor]];
    [self.label setTextColor:[UIColor blackColor]];
    [self.label setTextAlignment:NSTextAlignmentRight];
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.label];
    self.navigationItem.rightBarButtonItem = barButtonItem;
    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateZoom) userInfo:nil repeats:true];


}

-(void) updateZoom {
    self.label.text = [NSString stringWithFormat:@"%2.2f",self.scrollView.zoomScale];
    }


-(nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return image;
}
-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    NSLog(@"%2.2f",self.scrollView.zoomScale);
}
@end
