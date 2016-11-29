//
//  MenuView.m
//  WYMusic
//
//  Created by ios on 16/9/22.
//  Copyright © 2016年 wy. All rights reserved.
//

#import "MenuView.h"
#import "MenuSongsListCell.h"
#import "MusicListModel.h"


#define SCREEN_WIDTH ( [[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ( [[UIScreen mainScreen] bounds].size.height)
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1.0f]



@implementation MenuView

-(NSMutableArray *)data{
    if (!_data) {
        _data =[NSMutableArray array];
    }
    return _data;
}

-(NSMutableArray *)name{
    if (!_name) {
        _name =[NSMutableArray array];
    }
    return _name;
}
-(instancetype)initWithFrame:(CGRect)frame SongsArray:(NSArray *)songsArray playerTyper:(playerOfType )type{
    if (self = [super initWithFrame:frame]) {
        for (MusicListModel *model in songsArray) {
            [self.data addObject:model.songname];
            [self.name addObject:model.singername];
        }
         self.type = type;
        [self initMenuView];
    }
    return self;
}

-(void)initMenuView{
    self.backgroundColor = RGBCOLOR(22, 27, 33);
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(20, 9.5, 100, 21)];
    title.textColor =[UIColor whiteColor];
    title.font =[UIFont systemFontOfSize:16];
    title.text = @"播放列表";
    [self addSubview:title];
    
    self.playTypeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.playTypeBtn.frame = CGRectMake(SCREEN_WIDTH-40, 0, 40 , 40);
    switch (self.type) {
        case PlayerTypeNormal:
            [self.playTypeBtn setImage:[UIImage imageNamed:@"loop_all_icon"] forState:UIControlStateNormal];
            break;
        case PlayerTypeRandom:
             [self.playTypeBtn setImage:[UIImage imageNamed:@"shuffle_icon"] forState:UIControlStateNormal];
            break;
        case PlayerTypeSingle:
             [self.playTypeBtn setImage:[UIImage imageNamed:@"loop_single_icon"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
    [self.playTypeBtn addTarget:self action:@selector(changePlayerType) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.playTypeBtn];
    
    self.wTableView =[[UITableView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, SCREEN_HEIGHT/2-40) style:UITableViewStylePlain];
    self.wTableView.dataSource = self;
    self.wTableView.delegate = self;
    self.wTableView.backgroundColor = RGBCOLOR(22, 27, 33);
    self.wTableView.separatorColor = [UIColor darkGrayColor];
    [self.wTableView registerNib:[UINib nibWithNibName:@"MenuSongsListCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    
    [self addSubview:self.wTableView];
    [self.wTableView reloadData];
}

-(NSInteger )numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MenuSongsListCell *cell =[tableView dequeueReusableCellWithIdentifier:@"cell"];
    
        cell.backgroundColor = RGBCOLOR(22, 27, 33);
        cell.IndexLabel.textColor = [UIColor darkGrayColor];
        cell.IndexLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row+1];
        cell.songNameLabel.text = self.data[indexPath.row];
        [cell.songNameLabel sizeToFit];
        cell.singerNameLabel.text = self.name[indexPath.row];
        [cell.singerNameLabel sizeToFit];
        cell.singerNameLabel.textColor = [UIColor darkGrayColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
    if ([_delegate respondsToSelector:@selector(ClickSongsOfIndex:)]){
        [_delegate ClickSongsOfIndex:indexPath.row];
    }
    
}

-(void)changePlayerType{
    NSLog(@"%ld",self.type);
    self.type++;
    if (self.type == 3) {
        self.type = PlayerTypeNormal;
    }
    switch (self.type) {
        case PlayerTypeNormal: //循环播放
             [self.playTypeBtn setImage:[UIImage imageNamed:@"loop_all_icon"] forState:UIControlStateNormal];
            break;
        case PlayerTypeRandom://随机播放
            [self.playTypeBtn setImage:[UIImage imageNamed:@"shuffle_icon"] forState:UIControlStateNormal];
            break;
        case PlayerTypeSingle://单曲循环
            [self.playTypeBtn setImage:[UIImage imageNamed:@"loop_single_icon"] forState:UIControlStateNormal];
            break;
            
        default:
            break;
    }
    
    if ([_delegate respondsToSelector:@selector(changPlayerType:)]){
        [_delegate changPlayerType:self.type];
    }
    
}

@end
