//
//  SearchTableViewController.h
//  TYPlayer
//
//  Created by mac on 16/5/14.
//  Copyright © 2016年 mac. All rights reserved.
//

//http://route.showapi.com/213-1?showapi_sign=a3b9cb3921c74e0ba31d2d7b2fbbed77&showapi_appid=6091&keyword=nil

#import <UIKit/UIKit.h>
#import "ResultsViewController.h"

//
//@class SearchCell,searchModel;
//extern NSString *const kCellIdentifier;

@interface SearchTableViewController : UITableViewController


@property (nonatomic, strong)NSMutableArray *dataSource;

@property (nonatomic, strong) NSMutableDictionary *dic2;

@property (nonatomic, strong)UISearchController *searchController;


@end
