//
//  NHPokemon.m
//  Pokedex
//
//  Copyright (c) 2014 Noah Halford. All rights reserved.
//

#import "NHPokemon.h"

@implementation NHPokemon
@synthesize name, type, height, weight, number, description, sprite, cry;

- (id) initWithName:(NSString *)nm
               type:(NSString *)tp
             height:(NSInteger)ht
             weight:(NSInteger)wt
             number:(NSNumber *)num
        description:(NSString *)desc
             sprite:(NSString *)spriteName
                cry:(NSURL *)cryPath {
    self = [super init];
    if (self) {
        [self setName:nm];
        [self setType:tp];
        [self setHeight:ht];
        [self setWeight:wt];
        [self setNumber:num];
        [self setDescription:desc];
        [self setSprite:[UIImage imageNamed:spriteName]];
        [self setCry:cryPath];
    }
    return self;
}

@end
