//
//  MAIHistoryReflectionView.h
//  SurpriseApp
//
//  Created by 山口 恭兵 on 2014/05/14.
//  Copyright (c) 2014年 山口 恭兵. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ReflectionView.h"

@protocol MAIHistoryReflectionViewDelegate <NSObject>
- (void)takeAPicture;
@end

@interface MAIHistoryReflectionView : UIView

@property (weak, nonatomic) IBOutlet UIView *frontView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabe;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;

@property (weak, nonatomic) IBOutlet UIView *marryView;
@property (weak, nonatomic) IBOutlet UIImageView *marryImageView;
@property (weak, nonatomic) IBOutlet UIButton *marryImageButton;

@property (weak, nonatomic) id <MAIHistoryReflectionViewDelegate> _delegate;

@end
