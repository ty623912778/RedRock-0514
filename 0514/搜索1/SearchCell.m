//
//  SearchCell.m
//  0514
//
//  Created by mac on 16/5/15.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "SearchCell.h"

@implementation SearchCell


@synthesize songname;
@synthesize singername;
@synthesize albumpic_small;


- (void)setSingername:(NSString *)singerName
{
    if (![singerName isEqualToString:singername]) {
        singername = [singerName copy];
        self.singer.text = singername;
    }
}

- (void)setAlbumpic_small:(NSString *)albumpicsmall
{
    if (![albumpicsmall isEqualToString:albumpic_small]) {
        albumpic_small = [albumpicsmall copy];
        self.songPic.image = [UIImage imageNamed:albumpic_small];
    }
}
- (void)setSongname:(NSString *)songName
{
    if (![songName isEqualToString:songname]) {
        songname = [songName copy];
        self.song.text = songname;
    }
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
