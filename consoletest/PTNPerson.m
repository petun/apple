//
//  PTNPerson.m
//  consoletest
//
//  Created by petun on 07.11.13.
//  Copyright (c) 2013 petun. All rights reserved.
//

#import "PTNPerson.h"

@implementation PTNPerson


-(id)init {
    self = [super init];
    return self;
}

-(NSString *)fio {
    return [NSString stringWithFormat:@"%@ %@ %@",self.nachn,self.vorna,self.midnm];
}

-(NSString *)tel {
    return [NSString stringWithFormat:@"%@ %@",self.tel01,self.tel02];
}

-(NSString *)photo {
    return [NSString stringWithFormat:@"http://webstat.vsw.ru:85/photos/100x130/%@.jpg", self.pernr ];
}

@synthesize pernr=_pernr;
@synthesize nachn=_nachn;
@synthesize midnm=_midnm;
@synthesize vorna=_vorna;
@synthesize plans=_plans;
@synthesize orgExTxt=_orgExTxt;
@synthesize mail=_mail;





@end
