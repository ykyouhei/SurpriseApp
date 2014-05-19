//
//  MAIAddCardViewController.m
//  SurpriseApp
//
//  Created by 山口 恭兵 on 2014/05/17.
//  Copyright (c) 2014年 山口 恭兵. All rights reserved.
//

#import "MAIAddCardViewController.h"

#import "MAICardModel.h"
#import "MAICardModelManager.h"


@interface MAIAddCardViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *messageTextView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSDate *date;

@end

@implementation MAIAddCardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.date = [NSDate date];
    
    // 背景をキリックしたら、キーボードを隠す
    UITapGestureRecognizer *gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(closeSoftKeyboard)];
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/***************************************************/
#pragma mark - IB Action
/***************************************************/

- (IBAction)didTapOkButton:(id)sender
{
    MAICardModel *card = [[MAICardModel alloc] init];
    card.title = self.titleTextField.text;
    card.date = self.date;
    card.message = self.messageTextView.text;
    [[MAICardModelManager sharedManager].storedCards addObject:card];
    
    //[self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapCancelButton:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)didTapImageView:(id)sender
{
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc]init];
    imagePicker.delegate = self;
    [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:imagePicker animated:YES completion:nil];
}



/***************************************************/
#pragma mark - UIText Field Delegate
/***************************************************/

-(void)textFieldDidBeginEditing:(UITextField*)textField
{
    if (textField.tag == 1) {
        [textField resignFirstResponder];
        CKCalendarView *calendar = [[CKCalendarView alloc] init];
        [self.view addSubview:calendar];
        calendar.delegate = self;
    }
}


/***************************************************/
#pragma mark - CKCalendarView Delegate
/***************************************************/

- (void)calendar:(CKCalendarView *)calendar didSelectDate:(NSDate *)date {
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    [df setDateFormat:@"yyyy.MM.dd"];
    
    self.textField.text = [df stringFromDate:date];
    self.date = date;
    [calendar removeFromSuperview];
}

// キーボードを隠す処理
- (void)closeSoftKeyboard {
    [self.view endEditing: YES];
}


/***************************************************/
#pragma mark - UIImagePickerControllerDelegate
/***************************************************/

- (void)imagePickerController :(UIImagePickerController *)picker
        didFinishPickingImage :(UIImage *)image editingInfo :(NSDictionary *)editingInfo {
    [self.imageView setImage:image];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
