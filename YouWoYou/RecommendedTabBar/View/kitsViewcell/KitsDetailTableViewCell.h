//
//  KitsDetailTableViewCell.h
//  YouWoYou
//
//  Created by dlios on 15-3-26.
//  Copyright (c) 2015年 lanou3g.com 蓝欧科技. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Comment_listData.h"
#import "CommentListData1.h"
#import "StarView.h"


@interface KitsDetailTableViewCell : UITableViewCell

@property (nonatomic, retain) Comment_listData *comment;
@property (nonatomic, retain) UIImageView *avatar;
@property (nonatomic, retain) UILabel *userName;
@property (nonatomic, retain) StarView *stars;
@property (nonatomic, retain) UILabel *commentLabel;
@property (nonatomic, retain) CommentListData1 *comment1;

@end
