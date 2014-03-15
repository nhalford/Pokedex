//
//  PokemonViewController.h
//  Pokedex
//
//  Copyright (c) 2014 Noah Halford. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NHPokemon.h"
#import <AVFoundation/AVFoundation.h>

@interface PokemonViewController : UIViewController <UINavigationControllerDelegate, AVAudioPlayerDelegate>
{
    IBOutlet UILabel *heightLabel;
    IBOutlet UILabel *weightLabel;
    IBOutlet UILabel *typeLabel;
    IBOutlet UITextView *descView;
    IBOutlet UIImageView *imageView;
    IBOutlet UIButton *cryButton;
    AVAudioPlayer *audioPlayer;
}

@property (strong) NHPokemon *pokemon;
@property (strong) NSURL *cryPath;

- (IBAction)cry:(id)sender;

- (id)initWithPokemon:(NHPokemon *)pkmn;
- (NSString *)formatHeight;
- (NSString *)formatWeight;

@end
