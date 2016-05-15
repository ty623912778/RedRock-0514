//
//  searchModel.m
//  0514
//
//  Created by mac on 16/5/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "searchModel.h"

@implementation searchModel

+ (searchModel *) modelWithName:(NSString *)songsname singersname:(NSString *)singersname songPhotoData:(NSData *)songPhotoData{
    searchModel *newModel = [[self alloc] init];
    newModel.songsname=songsname;
    newModel.singersname=singersname;
    newModel.songPhotoData=songPhotoData;
    return newModel;
    
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.songsname forKey:NSStringFromSelector(@selector(songsname))];
    [aCoder encodeObject:self.singersname forKey:NSStringFromSelector(@selector(singersname))];
    [aCoder encodeObject:self.songPhotoData  forKey:NSStringFromSelector(@selector(songPhotoData))];
}
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder //NS_DESIGNATED_INITIALIZER
{
    self = [super init];
    if (self){
        _songsname = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(songsname))];
        _singersname = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(singersname))];
        _songPhotoData = [aDecoder decodeObjectForKey:NSStringFromSelector(@selector(songPhotoData))];
    }
    return self;
}
@end
