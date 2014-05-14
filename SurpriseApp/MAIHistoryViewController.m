//
//  MAIViewController.m
//  SurpriseApp
//
//  Created by 山口 恭兵 on 2014/05/13.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "MAIHistoryViewController.h"

#import "MAIHistoryReflectionView.h"

@interface MAIHistoryViewController ()
@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (nonatomic, strong) NSMutableArray *photos;

@property (weak, nonatomic) IBOutlet UIImageView *kyouhei;
@property (weak, nonatomic) IBOutlet UIImageView *mai;

@end

@implementation MAIHistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.carousel.type = iCarouselTypeInvertedTimeMachine;
    self.carousel.bounces = NO;
    
    self.photos = [NSMutableArray array];
    for (int i = 1; i < 6; i++) {
        [self.photos addObject:[UIImage imageNamed:[NSString stringWithFormat:@"photo_%d", i]]];
    }
    for (int i = 1; i < 6; i++) {
        [self.photos addObject:[UIImage imageNamed:[NSString stringWithFormat:@"photo_%d", i]]];
    }
    [self.carousel reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return [_photos count];
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(MAIHistoryReflectionView *)view
{
    //create new view if no view is available for recycling
    if (view == nil)
    {
        MAIHistoryReflectionView *historyView = [[MAIHistoryReflectionView alloc] initWithFrame:CGRectMake(0, 0, 260, 400)];
        view = historyView;
    }
    
    //set image
    ((MAIHistoryReflectionView *)view).imageView.image = _photos[index];
    [view update];
    return view;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    MAIHistoryReflectionView *view = (MAIHistoryReflectionView *)[carousel itemViewAtIndex:index];
    UIView *toView = [[UIView alloc] initWithFrame:view.contentView.frame];
    toView.backgroundColor = [UIColor whiteColor];
    toView.layer.cornerRadius = 5.0f;
    toView.clipsToBounds = YES;
    
    [UIView transitionFromView:view.contentView
                        toView:toView duration:0.3 options:UIViewAnimationOptionTransitionFlipFromLeft completion:^(BOOL finished) {
        
    }];
}

- (void)carouselDidScroll:(iCarousel *)carousel
{
    CGFloat rate = carousel.scrollOffset / (carousel.numberOfItems-1);
    NSLog(@"%f", rate);
    
    self.kyouhei.left = (self.view.width-self.kyouhei.width-10)/2*rate;
    self.mai.right = self.view.width - (self.view.width-self.mai.width-10)/2*rate;
}

@end
