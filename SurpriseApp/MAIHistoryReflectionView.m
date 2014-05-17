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
    
    self.frontView.frame = self.bounds;
    self.frontView.layer.cornerRadius = 5.0f;
    self.backView.frame = self.bounds;
    self.backView.layer.cornerRadius = 5.0f;
    self.backImageView.layer.cornerRadius = 5.0f;
    self.backView.hidden = YES;
    
    self.marryView.frame = self.bounds;
    self.marryView.layer.cornerRadius = 5.0f;
    self.marryView.hidden = YES;
    
    [self addSubview:self.frontView];
    [self addSubview:self.backView];
    [self addSubview:self.marryView];
}

- (IBAction)tapMerryButton:(id)sender {
    if ([self._delegate respondsToSelector:@selector(takeAPicture)]) {
        [self._delegate takeAPicture];
    }
}

@end
