//
//  mainTableViewController.m
//  0514
//
//  Created by mac on 16/5/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "mainTableViewController.h"
#import "PlayListTableViewController.h"
#import "musicList.h"
#import "SearchTableViewController.h"

@interface mainTableViewController ()


@end


@implementation mainTableViewController
@synthesize list = _list;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = [[NSArray alloc] initWithObjects:@"热门榜单",@"搜索",@"播放列表", nil];
    self.list = array;
    
}



#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.list count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"main";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell== nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
   cell.textLabel.text = [self.list objectAtIndex:[indexPath row]];
   
    return cell;
    
     }



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        
        PlayListTableViewController *playlist = [[PlayListTableViewController alloc]init];
        [self.navigationController pushViewController:playlist animated:YES];
    }else if (indexPath.row == 0)
    {
        
        musicList *musiclist = [[musicList alloc]init];
        [self.navigationController pushViewController:musiclist animated:YES];
    }else{
        
        SearchTableViewController *searchVC = [[SearchTableViewController alloc]init];
        [self.navigationController pushViewController:searchVC animated:YES];
    }
}


@end
