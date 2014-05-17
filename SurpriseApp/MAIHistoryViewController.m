//
//  MAIViewController.m
//  SurpriseApp
//
//  Created by 山口 恭兵 on 2014/05/13.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "MAIHistoryViewController.h"

#import "MAIHistoryReflectionView.h"
#import "MAICardModelManager.h"
#import "MAICardModel.h"

static NSString *const kMarryImageKey = @"kMarryImageKey";

@interface MAIHistoryViewController ()
@property (weak, nonatomic) IBOutlet iCarousel *carousel;

@property (weak, nonatomic) IBOutlet UIImageView *kyouhei;
@property (weak, nonatomic) IBOutlet UIImageView *mai;

@property (weak, nonatomic) MAICardModelManager *cardModelManager;

@property (strong, nonatomic) CAEmitterLayer *emitterLayer;

@end

@implementation MAIHistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self makeParcel];
    
    self.carousel.type = iCarouselOptionFadeMax;
    self.carousel.bounces = NO;
    
    self.cardModelManager = [MAICardModelManager sharedManager];
    [self.carousel reloadData];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.carousel reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)makeParcel
{
    self.emitterLayer = [CAEmitterLayer layer];
    
    self.emitterLayer.emitterPosition = CGPointMake(self.view.centerX, self.view.bottom -40);
    self.emitterLayer.renderMode = kCAEmitterLayerAdditive;
    
    CAEmitterCell *emitterCell = [CAEmitterCell emitterCell];
    UIImage *image = [UIImage imageNamed:@"heart"];
    emitterCell.contents = (__bridge id)(image.CGImage);
    emitterCell.emissionLongitude = M_PI*2;
    emitterCell.emissionRange = M_PI*2;
    emitterCell.birthRate = 20;
    emitterCell.lifetimeRange = 10.0;
    emitterCell.velocity = 300;
    emitterCell.xAcceleration = 10;
    emitterCell.yAcceleration = 10;
//    emitterCell.color = [UIColor colorWithRed:0.3
//                                        green:0.56
//                                         blue:0.36
//                                        alpha:0.5].CGColor;
    self.emitterLayer.emitterCells = @[emitterCell];
    self.emitterLayer.hidden = YES;
    [self.view.layer addSublayer:self.emitterLayer];
}

/***************************************************/
#pragma mark - IB Action
/***************************************************/

- (IBAction)didTapAddButton:(UIButton *)sender
{
}



/***************************************************/
#pragma mark - iCarousel Dalegate
/***************************************************/

-(CGFloat)carouselItemWidth:(iCarousel *)carousel
{
    return 280.0f;
}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.cardModelManager.storedCards.count + self.cardModelManager.tutorialCards.count;
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
    __weak MAICardModel *cardModel;
    if (self.cardModelManager.enableTutorial && index < self.cardModelManager.tutorialCards.count) {
        cardModel = self.cardModelManager.tutorialCards[index];
    } else {
        cardModel = self.cardModelManager.storedCards[index-self.cardModelManager.tutorialCards.count];
    }
    
    if (index == self.cardModelManager.tutorialCards.count - 1) {
        view.marryView.hidden = NO;
        view.backView.hidden = YES;
        
        NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:kMarryImageKey];
        if(imageData) {
            view.marryImageView.image = [UIImage imageWithData:imageData];
            view.marryImageButton.hidden = YES;
        } else {
            view._delegate = self;
        }
        return view;
    }

    view.backView.hidden = !cardModel.isBack;
    view.imageView.image = cardModel.mainImage;
    view.titleLabe.text = cardModel.title;
    view.dateLabel.text = [cardModel dateString];
    view.backImageView.image = [cardModel.mainImage applyLightEffect];
    
    return view;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    MAIHistoryReflectionView *view = (MAIHistoryReflectionView *)[carousel itemViewAtIndex:index];
    __weak MAICardModel *cardModel;
    if (self.cardModelManager.enableTutorial && index < self.cardModelManager.tutorialCards.count) {
        cardModel = self.cardModelManager.tutorialCards[index];
    } else {
        cardModel = self.cardModelManager.storedCards[index-self.cardModelManager.tutorialCards.count];
    }
    
    [UIView transitionWithView:view duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        view.backView.hidden = cardModel.isBack;
    } completion:^(BOOL finished) {
        cardModel.isBack = !cardModel.isBack;
    }];
}

- (void)carouselDidScroll:(iCarousel *)carousel
{
    CGFloat rate = carousel.scrollOffset / (carousel.numberOfItems-1);
    NSLog(@"%f", rate);
    
    self.emitterLayer.hidden = !(carousel.numberOfItems-1 == carousel.scrollOffset);
    self.kyouhei.left = (self.view.width-self.kyouhei.width-10)/2*rate;
    self.mai.right = self.view.width - (self.view.width-self.mai.width-10)/2*rate;
}

/***************************************************/
#pragma mark - MAIHistoryReflectionViewDelegate
/***************************************************/

-(void)takeAPicture
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *ipc =
        [[UIImagePickerController alloc] init];
        ipc.delegate = self;
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.allowsEditing = NO;

        [self presentViewController:ipc animated:YES completion:nil];
    }
}

/***************************************************/
#pragma mark - UIImagePickerControllerDelegate
/***************************************************/

-(void)imagePickerController:(UIImagePickerController*)picker
       didFinishPickingImage:(UIImage*)image editingInfo:(NSDictionary*)editingInfo{
    [self dismissModalViewControllerAnimated:YES];
    
    //保存
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(targetImage:didFinishSavingWithError:contextInfo:),
                                   NULL);
}

-(void)targetImage:(UIImage*)image
didFinishSavingWithError:(NSError*)error contextInfo:(void*)context{
    
    if(error == nil){
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSData *imageData = UIImageJPEGRepresentation(image, 1.0f);
        [ud setObject:imageData forKey:kMarryImageKey];
        [ud synchronize];
        
        [self.carousel reloadData];
    }
}
@end
