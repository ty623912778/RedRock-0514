//
//  PlayViewController.h
//  TYPlayer
//
//  Created by mac on 16/5/14.
//  Copyright © 2016年 mac. All rights reserved.
//m4a

#import <UIKit/UIKit.h>
@class PlayListTableViewController,musicModel;
typedef void(^PlayViewControllerBlock)(musicModel *musicmodel);


@interface PlayViewController : UIViewController
@property (nonatomic,assign) NSUInteger musicIndex;

@property (nonatomic, strong)    NSDictionary *listDictionary;
@property (nonatomic, strong) NSMutableArray *arrayData;

@property (nonatomic,strong)PlayViewControllerBlock block;

@end
