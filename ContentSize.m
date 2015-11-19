//
//  ContentSize.m
//  UIScrollView
//
//  Created by Hoàng Tiến on 11/19/15.
//  Copyright © 2015 Hoàng Tiến. All rights reserved.
//

#import "ContentSize.h"

@interface ContentSize ()<UIScrollViewDelegate>
@property (strong,nonatomic) UIScrollView *scrollView;

@end

@implementation ContentSize
{
    UIImageView *photo;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *image = [UIImage imageNamed:@"people.jpg"];
    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(8, 8, self.view.bounds.size.width -16, 300)];
    self.scrollView.backgroundColor = [UIColor grayColor];
    self.scrollView.contentSize = CGSizeMake(image.size.width, image.size.height);
    
    photo = [[UIImageView alloc]initWithImage:image];
    photo.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    self.scrollView.bounces = NO;
   // self.scrollView.showsHorizontalScrollIndicator  =  NO;
   // self.scrollView.showsVerticalScrollIndicator = YES;
    [self.scrollView addSubview:photo];
    [self.view addSubview:self.scrollView];
    
}


@end
