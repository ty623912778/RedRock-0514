//
//  SearchCell.h
//  0514
//
//  Created by mac on 16/5/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *songPic;
@property (weak, nonatomic) IBOutlet UILabel *song;
@property (weak, nonatomic) IBOutlet UILabel *singer;

@property(copy,nonatomic) NSString * songname;
@property(copy,nonatomic) NSString * singername;
@property(copy,nonatomic) NSString * albumpic_small;

@end
