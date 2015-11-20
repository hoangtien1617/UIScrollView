//
//  TapToScale.m
//  UIScrollView
//
//  Created by Hoàng Tiến on 11/19/15.
//  Copyright © 2015 Hoàng Tiến. All rights reserved.
//

#import "TapToScale.h"

@interface TapToScale ()<UIScrollViewDelegate, UIGestureRecognizerDelegate, UIAlertViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (strong,nonatomic) UIScrollView *scrollView;
@property (strong,nonatomic) UIImageView *photo;


@end

@implementation TapToScale

{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    scrollView.delegate = self;
    scrollView.minimumZoomScale = 0.1;
    scrollView.maximumZoomScale = 10.0;
    scrollView.zoomScale = 1.0;
    scrollView.clipsToBounds = true;
    UIImageView *photo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"HD.jpg"]];
    photo.frame = scrollView.bounds;
    photo.contentMode = UIViewContentModeScaleAspectFit;
    photo.userInteractionEnabled = true;
    photo.multipleTouchEnabled = true;
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap:)];
    singleTap.numberOfTapsRequired = 1;
    singleTap.delegate = self;
    [photo addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onDoubleTap:)];
    doubleTap.numberOfTapsRequired = 2;
    doubleTap.delegate = self;
    [photo addGestureRecognizer:doubleTap];
    
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    [self.view addSubview:scrollView];
    [scrollView addSubview:photo];
    
    self.scrollView = scrollView ;
    self.photo = photo;
    
    UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(selectImage)];
    
    [self.navigationItem setRightBarButtonItem:barButtonItem];
    
    
    // UIBarButtonItem* barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Image" style:UIBarButtonItemStylePlain target:self action:@selector(onAdd:)];
    // self.navigationItem.rightBarButtonItem = barButtonItem;
    
}

-(nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return self.photo;
}

-(void) onTap : (UITapGestureRecognizer *) tap {
    CGPoint tapPoint = [tap locationInView:self.photo ];
    float newScale = self.scrollView.zoomScale * 1.5 ;
    [self zoomRectForScale: newScale withCenter :tapPoint];
}

-(void) onDoubleTap : (UITapGestureRecognizer *) tap {
    CGPoint tapPoint = [tap locationInView:self.photo ];
    float newScale = self.scrollView.zoomScale / 1.5 ;
    [self zoomRectForScale: newScale withCenter :tapPoint];
}
- (void)zoomRectForScale:(float)scale
              withCenter:(CGPoint)center{
    CGRect zoomRect;
    CGSize scrollViewSize = self.scrollView.bounds.size;
    zoomRect.size.height = scrollViewSize.height / scale;
    zoomRect.size.width  = scrollViewSize.width  / scale;
    
    // choose an origin so as to get the right center.
    zoomRect.origin.x    = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y    = center.y - (zoomRect.size.height / 2.0);
    
    [self.scrollView zoomToRect:zoomRect
                       animated:YES];
    
    
}
-(void) selectImage {
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"About" message:self.choosePicture delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Take Pickture" , @"Choose Picture",nil];
    [alert show];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(buttonIndex ==0){
        NSLog(@"0");
    }
    else if (buttonIndex == 1){ //take picture
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIAlertView *myAlertView = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Device has no camera" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [myAlertView show];
            
        }else{
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = true;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:picker animated:YES completion:NULL];
        }
    }
    else if (buttonIndex == 2){ //choose picture
        NSLog(@"2");
        UIImagePickerController *picker = [[UIImagePickerController alloc]init];
        picker.delegate = self;
        picker.allowsEditing = true;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:picker animated:YES completion:NULL];
    }
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.photo.image = chosenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


@end
