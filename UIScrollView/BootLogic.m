//
//  BootLogic.m
//  TechmasterApp
//
//  Created by techmaster on 9/7/14.
//  Copyright (c) 2014 Techmaster. All rights reserved.
//

#import "BootLogic.h"
#import "MainScreen.h"


@implementation BootLogic
+ (void) boot: (UIWindow*) window
{
    MainScreen* mainScreen = [[MainScreen alloc] initWithStyle:UITableViewStyleGrouped];
    //--------- From this line, please customize your menu data -----------
    NSDictionary* basic = @{SECTION: @"ScrollView", MENU: @[
                                    @{TITLE: @"Scroll View", CLASS: @"ScrollView"},
                                    @{TITLE: @"UIScrollView With Slider", CLASS: @"UIScrollViewWithSlider"},
                                    @{TITLE: @"Content Size Basic", CLASS: @"ContentSize"},
                                    @{TITLE: @"Tap To Scale", CLASS: @"TapToScale"}

                                





                                    
                          ]};
    mainScreen.menu = @[basic];
    mainScreen.title = @"Bootstrap App";
    mainScreen.about = @"This is demo bootstrap demo app. It is collection of sample code of AVFoundation";
    //--------- End of customization -----------
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController: mainScreen];
    
    window.rootViewController = nav;
}
@end
