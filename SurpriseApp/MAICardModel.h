//
//  MAICardModel.h
//  SurpriseApp
//
//  Created by 山口 恭兵 on 2014/05/15.
//  Copyright (c) 2014年 山口 恭兵. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MAICardModelState) {
    MAICardModelStateFront,
    MAICardModelStateBack
};


/**
 *  カードデータ用モデル
 */
@interface MAICardModel : NSObject

@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UIImage *mainImage;
@property (strong, nonatomic) NSString *message;

@property (assign, nonatomic) MAICardModelState cardState;

@end
