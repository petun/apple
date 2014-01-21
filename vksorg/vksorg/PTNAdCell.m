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

-(void)setAd:(NSDictionary *)ad {
    _ad = ad;
    self.titleLabel.text = _ad[@"title"];
    self.priceLabel.text = [[NSString alloc] initWithFormat:@"%i руб.", [_ad[@"price"] intValue] ];
    
    NSDate *date = [_ad objectForKey:@"publishedon"];
    self.dateLabel.text = [date description];
    
    NSString *extra = _ad[@"meta"];
    
    if (![extra isEqualToString:@""]) {
        self.extraLabel.text = extra;
    } else {
        self.extraLabel.text = _ad[@"town"];
    }
    
    UIImage *image  = [[UIImage alloc] initWithData:[[NSData alloc] initWithContentsOfURL:[[NSURL alloc] initWithString:_ad[@"thumb"] ]]];
    
    
    self.imageView.image = image;
}

@end
