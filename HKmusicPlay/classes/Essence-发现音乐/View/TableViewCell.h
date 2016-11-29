//
//  TableViewCell.h
//  HKmusicPlay
//
//  Created by 黄坤 on 2016/10/31.
//  Copyright © 2016年 黄坤. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *heardimage;
@property (weak, nonatomic) IBOutlet UIImageView *songimage;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *number;

@end
