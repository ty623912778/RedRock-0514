//
//  musicModel.h
//  0514
//
//  Created by mac on 16/5/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface musicModel : NSObject

@property (copy, nonatomic)NSString *name;

@property (copy, nonatomic)UIImageView *icon;

@property (copy, nonatomic)NSString *mp3Url;

@property (copy, nonatomic)NSString *singer;

+(instancetype)musicWithName:(UILabel *)name Photo:(UIImageView *)icon Mp3Url:(NSString *)mp3Url Singer:(UILabel *)singer;


@end
