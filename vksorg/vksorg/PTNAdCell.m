//
//  PTNAdCell.m
//  vksorg
//
//  Created by Admin on 21.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "PTNAdCell.h"

@implementation PTNAdCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setAd:(NSDictionary *)ad {
    _ad = ad;
    self.titleLabel.text = _ad[@"title"];
    self.priceLabel.text = [[NSString alloc] initWithFormat:@"%i руб.", [_ad[@"price"] intValue] ];
}

@end
