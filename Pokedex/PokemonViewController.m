//
//  PokemonViewController.m
//  Pokedex
//
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
        [[self navigationItem] setTitle:[NSString stringWithFormat:@"%@. %@",[pkmn number],[pkmn name]]];
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[self cryPath] error:NULL];
        audioPlayer.delegate = self;
    }
    return self;
}

- (NSString *)formatHeight
{
    int h_as_int = (int)[self.pokemon height];
    int inches = h_as_int * 4;
    int feet = inches / 12;
    int rem = inches - (feet * 12);
    
    return([NSString stringWithFormat:@"Height: %d' %d\"",feet,rem]);
}

// weight in CSV is given as kg * 10
- (NSString *)formatWeight
{
    int w_as_int = (int)[self.pokemon weight];
    double w_kg = (double)w_as_int / 10.0;
    double w_lb = w_kg * 2.205;
    
    return([NSString stringWithFormat:@"Weight: %6.1lf lb",w_lb]);
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
    
    [typeLabel setText:[NSString stringWithFormat:@"Type: %@",[[self pokemon] type]]];
    [heightLabel setText:[self formatHeight]];
    [weightLabel setText:[self formatWeight]];
    [descView setText:[[self pokemon] description]];
    [imageView setImage:[[self pokemon] sprite]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
