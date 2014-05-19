//
//  MAITakePictureView.m
//  SurpriseApp
//
//  Created by 山口 恭兵 on 2014/05/19.
//  Copyright (c) 2014年 山口 恭兵. All rights reserved.
//

#import "MAITakePictureView.h"

@implementation MAITakePictureView

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
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.clipsToBounds = NO;
    
    self.cardView.frame = self.bounds;
    [self addSubview:self.cardView];
}

- (IBAction)didTapImage:(UITapGestureRecognizer *)sender
{
    if ([self.delegate respondsToSelector:@selector(takePictureViewDidTapImage:)]) {
        // sampleMethod2を呼び出す
        [self.delegate takePictureViewDidTapImage:self];
    }
}



@end
