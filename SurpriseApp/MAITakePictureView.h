//
//  MAITakePictureView.h
//  SurpriseApp
//
//  Created by 山口 恭兵 on 2014/05/19.
//  Copyright (c) 2014年 山口 恭兵. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MAITakePictureView;

@protocol MAITakePictureViewDelegate <NSObject>
- (void)takePictureViewDidTapImage:(MAITakePictureView *)view;
@end

@interface MAITakePictureView : UIView

@property (strong, nonatomic) IBOutlet UIView *cardView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) id<MAITakePictureViewDelegate> delegate;

@end
