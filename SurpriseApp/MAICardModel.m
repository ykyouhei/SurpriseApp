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
        _isBack = NO;
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
        _isBack = NO;
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

-(void)encodeWithCoder:(NSCoder*)encoder {
    [encoder encodeObject:self.date forKey:@"date"];
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.message forKey:@"message"];
    [encoder encodeObject:self.mainImage forKey:@"mainImage"];
    [encoder encodeBool:self.isBack forKey:@"isBack"];
}

-(id)initWithCoder:(NSCoder*)decoder {
    self = [super init];
    if (self) {
        self.date = [decoder decodeObjectForKey:@"date"];
        self.title = [decoder decodeObjectForKey:@"title"];
        self.message = [decoder decodeObjectForKey:@"message"];
        self.mainImage = [decoder decodeObjectForKey:@"mainImage"];
        self.isBack = [decoder decodeBoolForKey:@"isBack"];
    }
    return self;
}

@end
