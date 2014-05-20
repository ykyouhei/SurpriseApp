//
//  MAIViewController.m
//  SurpriseApp
//
//  Created by 山口 恭兵 on 2014/05/13.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "MAIHistoryViewController.h"

#import "MAICardModelManager.h"
#import "MAICardModel.h"

static NSString *const kMarryImageKey = @"kMarryImageKey";

@interface MAIHistoryViewController ()
@property (weak, nonatomic) IBOutlet iCarousel *carousel;
@property (weak, nonatomic) IBOutlet UIImageView *kyouhei;
@property (weak, nonatomic) IBOutlet UIImageView *mai;

@property (weak, nonatomic) MAICardModelManager *cardModelManager;
@property (strong, nonatomic) CAEmitterLayer *emitterLayer;

@property (assign, nonatomic) BOOL isTookPhoto;

@end

@implementation MAIHistoryViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self makeParcel];
    
    self.carousel.type = iCarouselTypeLinear;
    self.carousel.vertical = NO;
    self.carousel.bounces = NO;
    
    self.isTookPhoto = [[NSUserDefaults standardUserDefaults].dictionaryRepresentation.allKeys containsObject:kMarryImageKey];
    
    self.cardModelManager = [MAICardModelManager sharedManager];
    [self.carousel reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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

- (IBAction)addCardActionForSegue:(UIStoryboardSegue *)segue
{
    NSLog(@"First view return action invoked.");
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
    if (self.cardModelManager.enableTutorial) {
        return self.cardModelManager.storedCards.count + self.cardModelManager.tutorialCards.count;
    }
    
    return self.cardModelManager.storedCards.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(UIView *)view
{
    //create new view if no view is available for recycling
    // 写真撮影ビューの場合
    if (self.cardModelManager.enableTutorial &&
        index == self.cardModelManager.tutorialCards.count - 1) {
        MAITakePictureView *pictureView = [[MAITakePictureView alloc] initWithFrame:CGRectMake(0, 0, 234, 360)];
        pictureView.delegate = self;
        NSData* imageData = [[NSUserDefaults standardUserDefaults] objectForKey:kMarryImageKey];
        if(imageData) {
            pictureView.imageView.image = [UIImage imageWithData:imageData];
        }
        return pictureView;
    }
    
    if (view == nil || [view isKindOfClass:[MAITakePictureView class]])
    {
        MAIHistoryReflectionView *historyView = [[MAIHistoryReflectionView alloc] initWithFrame:CGRectMake(0, 0, 234, 360)];
        view = historyView;
    }
    __weak MAICardModel *cardModel;
    if (self.cardModelManager.enableTutorial && index < self.cardModelManager.tutorialCards.count) {
        cardModel = self.cardModelManager.tutorialCards[index];
    } else {
        cardModel = self.cardModelManager.storedCards[index];
    }
    ((MAIHistoryReflectionView *)view).backView.hidden = !cardModel.isBack;
    ((MAIHistoryReflectionView *)view).frontView.hidden = cardModel.isBack;
    ((MAIHistoryReflectionView *)view).imageView.image = cardModel.mainImage;
    ((MAIHistoryReflectionView *)view).titleLabe.text = cardModel.title;
    ((MAIHistoryReflectionView *)view).dateLabel.text = [cardModel dateString];
    
    return view;
}

- (void)carousel:(iCarousel *)carousel didSelectItemAtIndex:(NSInteger)index
{
    // 写真撮影ビューの場合
    if (self.cardModelManager.enableTutorial &&
        index == self.cardModelManager.tutorialCards.count - 1) {
        return;
    }
    
    MAIHistoryReflectionView *view = (MAIHistoryReflectionView *)[carousel itemViewAtIndex:index];
    __weak MAICardModel *cardModel;
    if (self.cardModelManager.enableTutorial && index < self.cardModelManager.tutorialCards.count) {
        cardModel = self.cardModelManager.tutorialCards[index];
    } else {
        cardModel = self.cardModelManager.storedCards[index];
    }
    
    [UIView transitionWithView:view duration:0.5 options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
        view.backView.hidden = cardModel.isBack;
        view.frontView.hidden = !cardModel.isBack;
    } completion:^(BOOL finished) {
        cardModel.isBack = !cardModel.isBack;
    }];
}

- (void)carouselDidScroll:(iCarousel *)carousel
{
    CGFloat rate = carousel.numberOfItems == 1 ? 0 : carousel.scrollOffset / (carousel.numberOfItems-1);
    NSLog(@"%f", rate);
    
    self.emitterLayer.hidden = !(carousel.numberOfItems-1 == carousel.scrollOffset) || !self.isTookPhoto;
    self.kyouhei.left = (self.view.width-self.kyouhei.width-10)/2*rate;
    self.mai.right = self.view.width - (self.view.width-self.mai.width-10)/2*rate;
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value
{
    if (option == iCarouselOptionSpacing) {
        return 0.9f;
    }
    return value;
}

/***************************************************/
#pragma mark - MAITakePictureViewDelegate
/***************************************************/

- (void)takePictureViewDidTapImage:(MAITakePictureView *)view
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
        
        self.isTookPhoto = YES;
        
        [self.carousel reloadData];
    }
}
@end
