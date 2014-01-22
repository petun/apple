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
    
    NSDate *date = [_ad objectForKey:@"publishedon"];
    self.dateLabel.text = [date description];
    
    NSString *extra = _ad[@"meta"];
    
    if (![extra isEqualToString:@""]) {
        self.extraLabel.text = extra;
    } else {
        self.extraLabel.text = _ad[@"town"];
    }
    
    // load image in additional thread
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        UIImage *image  = [[UIImage alloc] initWithData:[[NSData alloc] initWithContentsOfURL:[[NSURL alloc] initWithString:_ad[@"thumb"] ]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
            //    self.imageView.contentMode =UIViewContentModeScaleToFill;
            self.imageView.contentMode =UIViewContentModeScaleAspectFit;
            //    self.imageView.contentMode =UIViewContentModeScaleAspectFill;
            
            [self setNeedsLayout];

        });
        
    });
    
    
    
}

@end
