//
//  MAICardModelManager.h
//  SurpriseApp
//
//  Created by 山口 恭兵 on 2014/05/15.
//  Copyright (c) 2014年 山口 恭兵. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  カード用モデルを管理するシングルトンクラス
 */
@interface MAICardModelManager : NSObject

@property (strong, nonatomic, readonly) NSMutableArray *tutorialCards;
@property (strong, nonatomic, readonly) NSMutableArray *storedCards;
@property (assign, nonatomic) BOOL enableTutorial;

+ (MAICardModelManager *)sharedManager;

@end
