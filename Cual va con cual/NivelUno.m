//
//  NivelUno.m
//  Cual va con cual
//
//  Created by Gilberto Leon on 02/04/12.
//  Copyright 2012 Gilberto León. All rights reserved.
//

#import "NivelUno.h"

@interface NivelUno()
- (void)atras:(id)sender;
- (void)crearSprites:(int)numero;
- (void)escogerCartas;
@end

@implementation NivelUno

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	NivelUno *layer = [NivelUno node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

- (id)init
{
    self = [super init];
    if (self) {
        size = [[CCDirector sharedDirector] winSize];
        
        CCLabelTTF *titulo = [CCLabelTTF labelWithString:@"Nivel 1" fontName:@"Marker Felt" fontSize:40];
        titulo.position = ccp(size.width/2, size.height - titulo.contentSize.height);
        [self addChild:titulo z:1];
        
        CCMenuItemLabel *atrasButton = [CCMenuItemLabel itemWithLabel:[CreacionElementos crearLabelConTexto:@"Atrás" tamano:32] target:self selector:@selector(atras:)];
        CCMenu *menu = [CCMenu menuWithItems:atrasButton, nil];
        menu.position = ccp(size.width - atrasButton.contentSize.width/2, atrasButton.contentSize.height/2);
        [self addChild:menu z:1];
        
        cartasVisibles = 0;
        
        [self escogerCartas];
        [self crearSprites:4];
    }
    
    return self;
}

#pragma mark - Acciones

- (void)escogerCartas
{
    cartaUno = (arc4random() % 5)+1;
    cartaDos = (arc4random() % 5)+1;
    NSString *imagenUno = [NSString stringWithFormat:@"carta%d.png", cartaUno];
    NSString *imagenUnoA = [NSString stringWithFormat:@"carta%da.png", cartaUno];
    NSString *imagenDos = [NSString stringWithFormat:@"carta%d.png", cartaDos];
    NSString *imagenDosA = [NSString stringWithFormat:@"carta%da.png", cartaDos];
    cartas = [[NSArray arrayWithObjects:imagenUno, imagenUnoA, imagenDos, imagenDosA, nil] shuffled];
    [cartas retain];
}

- (void)atras:(id)sender
{
    CCScene *scene = [Titulo scene];
    [[CCDirector sharedDirector] replaceScene:scene];
}

- (void)spriteSelected:(CCMenuItemImage *)sender
{
    NSLog(@"seleccionado");
    
    if (cartasVisibles == 2) {
        cartaAnterior.normalImage = [CCSprite spriteWithFile:@"fondo.png"];
        cartaAnterior.selectedImage = [CCSprite spriteWithFile:@"fondo.png"];
        cartaAnteAnterior.normalImage = [CCSprite spriteWithFile:@"fondo.png"];
        cartaAnteAnterior.selectedImage = [CCSprite spriteWithFile:@"fondo.png"];
        sender.normalImage = [CCSprite spriteWithFile:[cartas objectAtIndex:sender.tag]];
        sender.selectedImage = [CCSprite spriteWithFile:[cartas objectAtIndex:sender.tag]];
        cartaAnterior = sender;
        cartasVisibles = 1;
    } else if (cartasVisibles == 1) {
        if (1 == 2) {
            sender.normalImage = [CCSprite spriteWithFile:[cartas objectAtIndex:sender.tag]];
            sender.selectedImage = [CCSprite spriteWithFile:[cartas objectAtIndex:sender.tag]];
            [sender setIsEnabled:NO];
            [cartaAnterior setIsEnabled:NO];
            cartasVisibles = 0;
        } else {
            sender.normalImage = [CCSprite spriteWithFile:[cartas objectAtIndex:sender.tag]];
            sender.selectedImage = [CCSprite spriteWithFile:[cartas objectAtIndex:sender.tag]];
            cartaAnteAnterior = cartaAnterior;
            cartaAnterior = sender;
            cartasVisibles = 2;
        }
    } else {
        sender.normalImage = [CCSprite spriteWithFile:[cartas objectAtIndex:sender.tag]];
        sender.selectedImage = [CCSprite spriteWithFile:[cartas objectAtIndex:sender.tag]];
        cartaAnterior = sender;
        cartasVisibles = 1;
    }
}

- (void)crearSprites:(int)numero
{
    menuUno = [CCMenu menuWithItems:nil];
    menuDos = [CCMenu menuWithItems:nil];
    
    for (int i = 0; i < numero/2; i++) {
        [menuUno addChild:[CCMenuItemImage itemFromNormalImage:@"fondo.png" selectedImage:@"fondo.png" target:self selector:@selector(spriteSelected:)] z:1 tag:i];
    }
    [menuUno alignItemsHorizontallyWithPadding:10];
    menuUno.position = ccp(size.width/2, size.height/2 + 40);
    [self addChild:menuUno];
    
    for (int i = numero/2; i < numero; i++) {
        [menuDos addChild:[CCMenuItemImage itemFromNormalImage:@"fondo.png" selectedImage:@"fondo.png" target:self selector:@selector(spriteSelected:)] z:1 tag:i];
    }
    [menuDos alignItemsHorizontallyWithPadding:10];
    menuDos.position = ccp(size.width/2, size.height/2 - 70);
    [self addChild:menuDos];
}

@end