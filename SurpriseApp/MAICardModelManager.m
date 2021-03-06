//
//  MAICardModelManager.m
//  SurpriseApp
//
//  Created by 山口 恭兵 on 2014/05/15.
//  Copyright (c) 2014年 山口 恭兵. All rights reserved.
//

#import "MAICardModelManager.h"
#import "MAICardModel.h"

static MAICardModelManager *_sharedInstance = nil;

static NSString *const kStoredCardKey = @"StoredCards";
static NSString *const kEnableTutorial = @"enableTutorial";

@interface MAICardModelManager ()
@property (strong, nonatomic) NSMutableArray *array;
@end

@implementation MAICardModelManager

+ (MAICardModelManager *)sharedManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[MAICardModelManager alloc] init];
    });
    return _sharedInstance;
}

- (id)init
{
    self = [super init];
    if (self) {
        [self p_setUpDefaults];
        [self p_setUpTutorialCards];
        [self addObserver:self
               forKeyPath:@"array"
                  options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                  context:nil];
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kStoredCardKey];
        _array = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (!_array) {
            _array = [[NSMutableArray alloc] init];
        }
        _storedCards = [self mutableArrayValueForKey:@"array"];
    }
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context
{
    if ([keyPath isEqualToString:@"array"]) {
        NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_storedCards];
        [ud setObject:data forKey:kStoredCardKey];
        [ud synchronize];
    }
}

/***************************************************/
#pragma mark - Accessor Method
/***************************************************/

- (BOOL)enableTutorial
{
    return [[NSUserDefaults standardUserDefaults] boolForKey:kEnableTutorial];
}

- (void)setEnableTutorial:(BOOL)enableTutorial
{
    [[NSUserDefaults standardUserDefaults] setBool:enableTutorial forKey:kEnableTutorial];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/***************************************************/
#pragma mark - Private Method
/***************************************************/

/**
 *  Tutorial用カードモデルを作成する
 */
- (void)p_setUpTutorialCards
{
    _tutorialCards = [NSMutableArray array];

    NSBundle* bundle = [NSBundle mainBundle];
    //読み込むファイルパスを指定
    NSString* path = [bundle pathForResource:@"Text" ofType:@"plist"];
    NSArray* arr = [NSArray arrayWithContentsOfFile:path];
    NSInteger i = 1;
    for (NSDictionary *dic in arr) {
        MAICardModel *card = [[MAICardModel alloc] init];
        card.mainImage = [UIImage imageNamed:(NSString*)[NSString stringWithFormat:@"photo_%ld", (long)i]];
        card.title = dic[@"title"];
        card.message = dic[@"message"];
        card.date = dic[@"date"];
        [self.tutorialCards addObject:card];
        i++;
    }
}

- (void)p_setUpDefaults
{
    NSMutableDictionary* keyValues = [NSMutableDictionary dictionary];
    [keyValues setObject:@"YES" forKey:kEnableTutorial];
    [[NSUserDefaults standardUserDefaults] registerDefaults:keyValues];
}

@end
