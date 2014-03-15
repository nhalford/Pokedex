//
//  NHPokemon.h
//  Pokedex
//
//  Created by Noah Halford on 3/12/14.
//  Copyright (c) 2014 Noah Halford. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NHPokemon : NSObject

@property (strong) NSString *name;
@property (strong) NSString *type;
@property NSInteger height;
@property NSInteger weight;
@property (strong) NSNumber *number; // Integer between 1 and 151
@property (strong) NSString *description;
@property (strong) UIImage *sprite;
@property (strong) NSURL *cry; // file path to cry sound file

- (id)initWithName:(NSString *)nm
              type:(NSString *)tp
            height:(NSInteger)ht
            weight:(NSInteger)wt
            number:(NSNumber *)num
       description:(NSString *)desc
            sprite:(NSString *)spriteName
               cry:(NSURL *)cryPath;

@end
