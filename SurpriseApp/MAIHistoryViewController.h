//
//  MAIViewController.h
//  SurpriseApp
//
//  Created by 山口 恭兵 on 2014/05/13.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <iCarousel/iCarousel.h>
#import "MAIHistoryReflectionView.h"
#import "MAITakePictureView.h"

@interface MAIHistoryViewController : UIViewController
<iCarouselDataSource,
iCarouselDelegate,
MAITakePictureViewDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate>

@end
