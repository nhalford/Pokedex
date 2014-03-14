//
//  PokemonViewController.m
//  Pokedex
//
//  Created by Noah Halford on 3/12/14.
//  Copyright (c) 2014 Noah Halford. All rights reserved.
//

#import "PokemonViewController.h"
#import "NHPokemon.h"
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface PokemonViewController ()

@end

@implementation PokemonViewController

- (IBAction)cry:(id)sender
{
    [audioPlayer play];
}

- (id)initWithPokemon:(NHPokemon *)pkmn
{
    self = [super initWithNibName:@"PokemonViewController" bundle:nil];
    if (self) {
        [self setPokemon:pkmn];
        [self setCryPath:[pkmn cry]];
        [[self navigationItem] setTitle:[NSString stringWithFormat:@"%@. %@",[pkmn number], [pkmn name]]];
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[self cryPath] error:NULL];
        audioPlayer.delegate = self;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [cryButton setHidden:NO];
    
    [heightLabel setText:@"Placeholder height"];
    [weightLabel setText:@"Placeholder weight"];
    [descView setText:[[self pokemon] description]];
    [imageView setImage:[[self pokemon] sprite]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
