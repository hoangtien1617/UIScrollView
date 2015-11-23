//
//  PagingScrollView.m
//  UIScrollView
//
//  Created by Hoàng Tiến on 11/23/15.
//  Copyright © 2015 Hoàng Tiến. All rights reserved.
//

#define PHOTO_WIDTH 320
#define PHOTO_HEIGHT 480
#define NUM_PHOTO 5

#import "PagingScrollView.h"

@interface PagingScrollView () <UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;

@end

@implementation PagingScrollView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    CGSize size =  self.view.bounds.size;
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake((size.width-PHOTO_WIDTH)*0.5, 0, PHOTO_WIDTH, PHOTO_HEIGHT)];
    self.scrollView.delegate = self;
    self.scrollView.backgroundColor = [UIColor grayColor];
    self.scrollView.contentSize = CGSizeMake(PHOTO_WIDTH * NUM_PHOTO, PHOTO_HEIGHT);
    self.scrollView.pagingEnabled = true;
    for (int i = 1; i<NUM_PHOTO + 1; i++) {
        NSString *fileName = [NSString stringWithFormat:@"%d.jpg",i];
        UIImage *image = [UIImage imageNamed:fileName];
        UIImageView *photo = [[UIImageView alloc]initWithImage:image];
        photo.contentMode = UIViewContentModeScaleAspectFit;
        photo.frame = CGRectMake((i-1) * PHOTO_WIDTH, 0, PHOTO_WIDTH, PHOTO_HEIGHT);
        [self.scrollView addSubview:photo];
    }
    [self.view addSubview:self.scrollView];
    self.pageControl = [[ UIPageControl alloc]initWithFrame:CGRectMake(0, size.height - 64 - 40, size.width, 40)];
    self.pageControl.backgroundColor    = [UIColor lightGrayColor];
    self.pageControl.numberOfPages = NUM_PHOTO;
    [self.pageControl addTarget:self
                         action:@selector(onPageChange:)
               forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.pageControl];
}
-(void)onPageChange:(id)sender {
    self.scrollView.contentOffset = CGPointMake(self.pageControl.currentPage * PHOTO_WIDTH, 0);
    
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = self.scrollView.contentOffset.x / PHOTO_WIDTH;
}
- (void)viewDidDisappear:(BOOL)animated {
    self.scrollView.delegate = nil;
}
@end
