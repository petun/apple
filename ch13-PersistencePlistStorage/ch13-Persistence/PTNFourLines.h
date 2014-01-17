//
//  PTNFourLines.h
//  ch13-PersistencePlistStorage
//
//  Created by Admin on 17.01.14.
//  Copyright (c) 2014 petun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTNFourLines : NSObject <NSCoding,NSCopying>

@property (copy,nonatomic) NSArray *lines;

@end
