//
//  NivelUno.h
//  Cual va con cual
//
//  Created by Gilberto Leon on 02/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "NSArray+Helpers.h"
#import "CreacionElementos.h"
#import "Titulo.h"

@interface NivelUno : CCLayer 
{
    CGSize size;
    NSArray *cartas;
    CCMenu *menuUno;
    CCMenu *menuDos;
    int cartaUno;
    int cartaDos;
    
    int cartasVisibles;
    CCMenuItemImage *cartaAnterior;
    CCMenuItemImage *cartaAnteAnterior;
}

+ (CCScene *)scene;

@end