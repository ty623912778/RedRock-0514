//
//  PlayListTableViewController.m
//  TYPlayer
//
//  Created by mac on 16/5/14.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "PlayListTableViewController.h"
#import "musicList.h"
#import "musicModel.h" 
#import "PlayViewController.h"


#define TYFilePath [ NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"musics.data"]


@interface PlayListTableViewController ()<UIActionSheetDelegate>
@property (nonatomic, strong)NSMutableArray *musics;


@end

@implementation PlayListTableViewController

- (NSMutableArray *)musics
{
    if (_musics == nil) {
        _musics = [NSKeyedUnarchiver unarchiveObjectWithFile:TYFilePath];
        if (_musics == nil) {
            _musics = [NSMutableArray array];
        }
    }
    return _musics;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    PlayViewController *playVC = segue.destinationViewController;
    playVC.block = ^(musicModel *musicmodel){
        [self.musics addObject:musicmodel];
        [self.tableView reloadData];
    };
    [NSKeyedArchiver archiveRootObject:self.musics toFile:TYFilePath];
}

- (void)playViewController:(PlayViewController *)playVC didClickAddBtnWithContact:(musicModel *)music{
    [self.musics addObject:music];
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.musics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellIdentifier = @"playlist";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell== nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    musicModel *m = self.musics[indexPath.row];
    cell.textLabel.text = m.name;
    cell.detailTextLabel.text = m.singer;
    cell.imageView.image = m.icon.image;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    PlayViewController *playView = [[PlayViewController alloc]init];
    playView = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"myPlayViewController"];
    
  //  playView.listDictionary = _dic2;
    
    playView.musicIndex = indexPath.row;
    
    
    [self.navigationController pushViewController:playView animated:YES];
}




@end
