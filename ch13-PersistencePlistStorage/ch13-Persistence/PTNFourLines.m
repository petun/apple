//
//  PTNFourLines.m
//  ch13-PersistencePlistStorage
//
//  Created by Admin on 17.01.14.
//  Copyright (c) 2014 petun. All rights reserved.
//

#import "PTNFourLines.h"

static NSString * const kLinesKey = @"kLinesKey";

@implementation PTNFourLines

#pragma mark Coding
// метод запускается в момент инициализации
// PTNFourLines *lines = [unarchiver decodeObjectForKey:kRootKey];
-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        self.lines = [aDecoder decodeObjectForKey:kLinesKey];
    }
    return self;
}

// выполняет при кодировании объекта - архивером
// метод является делегатом и просто говорит что делать самому архиверу
-(void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.lines forKey:kLinesKey];
}



#pragma mark Copying
-(id)copyWithZone:(NSZone *)zone {
    PTNFourLines *copy = [[PTNFourLines alloc] init];

    NSMutableArray *linesCopy = [NSMutableArray array];
    for (id line in self.lines) {
        [linesCopy addObject:line];
    }
    
    copy.lines = linesCopy;
    return copy;
}

@end
