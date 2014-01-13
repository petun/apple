//
//  PTNXmlParserDelegate.h
//  consoletest
//
//  Created by petun on 05.12.13.
//  Copyright (c) 2013 petun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PTNPerson.h"

@interface PTNXmlParserDelegate : NSObject<NSXMLParserDelegate> {
    BOOL m_done;
    NSError* m_error;
    
    PTNPerson* _cPerson;
    NSMutableArray* _personCollection;
    
    NSString* _cElement;
    NSMutableString* _cValue;
    
}

@property (readonly) BOOL done;
@property (readonly) PTNPerson * cPerson;
@property (readonly) NSMutableArray* personCollection;



@end
