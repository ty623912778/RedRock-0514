//
//  musicModel.m
//  0514
//
//  Created by mac on 16/5/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "musicModel.h"

@implementation musicModel

static NSString *nameKey = @"name";
static NSString *singerKey = @"phone";
static NSString *mp3UrlKey = @"name";
static NSString *iconKey = @"phone";

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:nameKey];
    [aCoder encodeObject:_icon forKey:iconKey];
    [aCoder encodeObject:_singer forKey:singerKey];
    [aCoder encodeObject:_mp3Url forKey:mp3UrlKey];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _name = [aDecoder decodeObjectForKey:nameKey];
        _icon = [aDecoder decodeObjectForKey:iconKey];
        _singer = [aDecoder decodeObjectForKey:singerKey];
        _mp3Url = [aDecoder decodeObjectForKey:mp3UrlKey];
    }
    
    
    return self;
}


+(instancetype)musicWithName:(UILabel *)name Photo:(UIImageView *)icon Mp3Url:(NSString *)mp3Url Singer:(UILabel *)singer{
    
    
    musicModel *m = [[self alloc] init];
    
    m.name = name.text;
    m.icon = icon;
    m.singer = singer.text;
    m.mp3Url = mp3Url;
    
    return m;
    
}


@end
