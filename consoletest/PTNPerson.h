//
//  PTNPerson.h
//  consoletest
//
//  Created by petun on 07.11.13.
//  Copyright (c) 2013 petun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PTNPerson : NSObject {
    NSNumber *  _pernr;
    NSString *  _nachn; // fami
    NSString *  _vorna; // name
    NSString *  _midnm; // otch
    NSString *  _orgExTxt; //
    NSString *  _plans; // должность

    NSString *  _bukrsName;

    NSString *  _mail;
    NSString *  _tel01;
    NSString *  _tel02;

    
    NSString * _fio;
    NSString * _photo;
}

@property (readonly) NSString* fio;
@property NSNumber* pernr;
@property NSString* nachn;
@property NSString* vorna;
@property NSString* midnm;
@property NSString* orgExTxt;
@property NSString* plans; // должность
@property NSString* bukrsName;
@property NSString* mail;
@property (readonly) NSString* tel; // all telephones

@property NSString* tel01;
@property NSString* tel02;

@property (readonly) NSString* photo;



/*@property int gg ;
-(int)tralala;

-(void)fuck: (int) one;
-(void)fuck:(int)one andTow: (int) two;*/

@end
