//
//  President.h
//  chapter-9-many-tableviews
//
//  Created by petun on 14.01.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface President : NSObject <NSCopying,NSCoding>

@property (assign,nonatomic) NSInteger number;
@property (copy,nonatomic) NSString *name;
@property (copy,nonatomic) NSString *fromYear;
@property (copy,nonatomic) NSString *toYear;
@property (copy,nonatomic) NSString *party;

@end
