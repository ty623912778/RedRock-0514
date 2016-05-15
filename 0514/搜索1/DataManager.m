//
//  DataManager.m
//  0514
//
//  Created by mac on 16/5/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "DataManager.h"
#import "musicList.h"
#import "searchModel.h"

@implementation DataManager
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.testDataArray = [self createTestDataArray];
    }
    return self;
}

-(NSMutableArray *)createTestDataArray
{
    musicList *mus1 = [[musicList alloc]init];
    NSMutableArray *testModel= [[NSMutableArray alloc] init];
    testModel = mus1.dataSource;
    NSMutableDictionary *testModels1 = [[NSMutableDictionary alloc]init];
    testModels1 = mus1.dic2;
    
    [testModel addObject:[searchModel modelWithName:testModels1[@"songname"] singersname:testModels1[@"singername"] songPhotoData:[NSData dataWithContentsOfURL:[NSURL URLWithString:testModels1[@"albumpic_small"]]]]];
    
    return testModel;
}
@end
