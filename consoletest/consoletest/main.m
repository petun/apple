//
//  main.m
//  consoletest
//
//  Created by petun on 01.11.13.
//  Copyright (c) 2013 petun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTNPerson.h"
#import "PTNXmlParserDelegate.h"

int main(int argc, const char * argv[])
{

    @autoreleasepool {
        
        NSURL * xmlUrl  = [NSURL URLWithString:@"http://ps.vsw.ru/persons/persons.xml"];
        
        NSXMLParser * parser =  [[NSXMLParser alloc] initWithContentsOfURL:xmlUrl];
        
        PTNXmlParserDelegate * d = [PTNXmlParserDelegate new];
        
        
        [parser setDelegate:d];
        [parser parse];
        
        while ( ! d.done )
            sleep(1);
        
        NSLog(@"Parse data OK");
        NSLog(@"Found %lu Objects",(unsigned long)d.personCollection.count);
        
        for (id pID in d.personCollection) {
            if ([pID isKindOfClass:[PTNPerson class]]) {
                PTNPerson * tmp = pID;
                
                NSLog(@"[%@] %@ (%@, %@) - %@ %@",tmp.pernr, tmp.fio, tmp.orgExTxt,tmp.bukrsName,tmp.mail,tmp.tel);
            }
        }
        
        /*PTNPerson * p =[d.personCollection objectAtIndex:0];
        
        NSLog(@"[%@] %@ (%@, %@) - %@ %@",p.pernr, p.fio,p.orgExTxt,p.bukrsName,p.mail,p.tel);*/
        
        
        
        
        
        
        
    }
    return 0;
}

