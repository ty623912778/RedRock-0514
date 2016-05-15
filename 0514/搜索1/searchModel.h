//
//  searchModel.h
//  0514
//
//  Created by mac on 16/5/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface searchModel : NSObject<NSCopying>

@property (nonatomic,copy)   NSString *songsname;
@property (nonatomic,copy)   NSString *singersname;
@property (nonatomic,strong) NSData   *songPhotoData;


+ (searchModel *) modelWithName:(NSString *)songsname singersname:(NSString *)singersname songPhotoData:(NSData *)songPhotoData;

@end
