//
//  AddressBookCell.m
//  xiaoZhang
//
//  Created by nick_beibei on 2018/12/6.
//  Copyright © 2018年 胡胡超. All rights reserved.
//

#import "AddressBookCell.h"

@implementation AddressBookCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self) {
        if(self) {
            UIImageView *iconView = [[UIImageView alloc] init];
            iconView.frame = CGRectMake(20, 10, 40, 40);
            [self.contentView addSubview:iconView];
            self.iconView = iconView;
            iconView.layer.cornerRadius = 20;
            iconView.clipsToBounds = YES;
            
            UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(80, 10, 200, 40)];
            nameLabel.font = [UIFont systemFontOfSize:18];
            nameLabel.textAlignment = NSTextAlignmentLeft;
            [self.contentView addSubview:nameLabel];
            self.nameLabel = nameLabel;
        }
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
