//
//  MAIHistoryReflectionView.h
//  SurpriseApp
//
//  Created by 山口 恭兵 on 2014/05/14.
//  Copyright (c) 2014年 山口 恭兵. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "ReflectionView.h"

@interface MAIHistoryReflectionView : ReflectionView

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;


@end
