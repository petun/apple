//
//  PTNAdCell.h
//  vksorg
//
//  Created by Admin on 21.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PTNAdCell : UITableViewCell


@property (strong,nonatomic) IBOutlet UIImageView *imageView;

@property (strong,nonatomic) IBOutlet UILabel *titleLabel;
@property (strong,nonatomic) IBOutlet UILabel *priceLabel;
@property (strong,nonatomic) IBOutlet UILabel *extraLabel;
@property (strong,nonatomic) IBOutlet UILabel *dateLabel;

@property (strong,nonatomic) NSDictionary *ad;

@end
