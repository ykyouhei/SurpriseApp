//
//  MAICardModel.m
//  SurpriseApp
//
//  Created by 山口 恭兵 on 2014/05/15.
//  Copyright (c) 2014年 山口 恭兵. All rights reserved.
//

#import "MAICardModel.h"

@implementation MAICardModel

- (id)init
{
    self = [super init];
    if (self) {
        _cardState = MAICardModelStateFront;
    }
    return self;
}

- (id)initWithDate:(NSDate *)date
             title:(NSString *)title
         mainImage:(UIImage *)image
           message:(NSString *)message
{
    self = [super init];
    if (self) {
        _cardState = MAICardModelStateFront;
        _date = date;
        _title = title;
        _mainImage = image;
        _message = message;
    }
    return self;
}

- (NSString *)dateString
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    [df setDateFormat:@"yyyy年MM月dd日"];
    
    return [df stringFromDate:_date];
}

@end
