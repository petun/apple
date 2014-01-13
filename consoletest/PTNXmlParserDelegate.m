//
//  PTNXmlParserDelegate.m
//  consoletest
//
//  Created by petun on 05.12.13.
//  Copyright (c) 2013 petun. All rights reserved.
//

#import "PTNXmlParserDelegate.h"

@implementation PTNXmlParserDelegate

@synthesize done=m_done;
@synthesize cPerson=_cPerson;
@synthesize personCollection=_personCollection;


- (id)init{
    _personCollection = [NSMutableArray new];
    return self;
}

// документ начал парситься
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    m_done = NO;
    NSLog(@"Document begin parsing");
}


// парсинг окончен
- (void)parserDidEndDocument:(NSXMLParser *)parser {
    m_done = YES;
    NSLog(@"Parsing End");
}

// если произошла ошибка парсинга
-(void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    m_done = YES;
    m_error = parseError;
}
// если произошла ошибка валидации
-(void) parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError {
    m_done = YES;
    m_error = validationError;
}

// встретили новый элемент
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName  isEqual: @"message"]) {
        _cPerson = [PTNPerson new];
        NSLog(@"create new PTNPerson object");
    }
    _cElement = elementName;
    NSLog(@"Start element - %@ / clear cValue", _cElement);
    
    _cValue = [NSMutableString new];
    
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    NSString* r = [[_cValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    
    
    if ([elementName isEqual:@"pernr"]) {
        _cPerson.pernr =  [[NSNumber alloc] initWithInteger:[r integerValue]];
    }
    
    if ([elementName isEqual:@"nachn"]) {
        _cPerson.nachn = r;
    }
    if ([elementName isEqual:@"vorna"]) {
        _cPerson.vorna = r;
    }
    
    if ([elementName isEqual:@"midnm"]) {
        _cPerson.midnm = r;
    }
    
    if ([elementName isEqual:@"orgeh_txt"]) {
        _cPerson.orgExTxt = r;
    }
    
    if ([elementName isEqual:@"bukrsname"]) {
        _cPerson.bukrsName = r;
    }
    
    if ([elementName isEqual:@"mail"]) {
        _cPerson.mail = r;
    }
    
    if ([elementName isEqual:@"tel01"]) {
        _cPerson.tel01 = r;
    }
    
    if ([elementName isEqual:@"tel02"]) {
        _cPerson.tel02 = r;
    }
    
    
    if ([elementName isEqual:@"plans_txt"]) {
        _cPerson.plans = r;
    }

    
    if ([elementName  isEqual: @"message"]) {
        [_personCollection addObject:_cPerson];
    }
    
    //NSLog(@"");
    
    //[_cValue release];
    
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    // если сейчас получаем значение элемента title
    // добавим часть его значения к строке
    [_cValue appendString:string];
}
@end
