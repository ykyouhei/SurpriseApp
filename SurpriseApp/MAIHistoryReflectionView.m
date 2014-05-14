//
//  MAIHistoryReflectionView.m
//  SurpriseApp
//
//  Created by 山口 恭兵 on 2014/05/14.
//  Copyright (c) 2014年 山口 恭兵. All rights reserved.
//

#import "MAIHistoryReflectionView.h"

@implementation MAIHistoryReflectionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self p_commonInit];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self p_commonInit];
    }
    return self;
}

- (void)p_commonInit
{
    NSString *className = NSStringFromClass([self class]);
    [[NSBundle mainBundle] loadNibNamed:className owner:self options:0];
    
    self.backgroundColor = [UIColor clearColor];
    
    self.contentView.frame = self.bounds;
    self.contentView.layer.cornerRadius = 5.0f;
    
    [self addSubview:self.contentView];
}

@end
