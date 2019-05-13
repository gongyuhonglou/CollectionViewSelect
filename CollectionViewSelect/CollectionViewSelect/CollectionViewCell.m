//
//  CollectionViewCell.m
//  CollectionViewSelect
//
//  Created by rpweng on 2019/5/13.
//  Copyright © 2019 rpweng. All rights reserved.
//

#import "CollectionViewCell.h"

@implementation CollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        
        [self initUI];
        [self setBackgroundColor:[UIColor grayColor]];
    }
    
    return self;
}

- (void)initUI {
    
    CGFloat nameH = 20;
    CGSize cellSize = self.frame.size;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, (cellSize.height - nameH) * 0.5, cellSize.width, nameH)];
    [nameLabel setFont:[UIFont systemFontOfSize:16]];
    [nameLabel setTextAlignment:NSTextAlignmentCenter];
    [self.contentView addSubview:nameLabel];
    self.nameLabel = nameLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
