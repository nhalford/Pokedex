//
//  PokedexViewController.m
//  Pokedex
//
//  Copyright (c) 2014 Noah Halford. All rights reserved.
//

#import "PokedexViewController.h"
#import "NHPokemon.h"
#import "CHCSVParser.h"
#import "PokemonViewController.h"

@interface PokedexViewController ()

@end

@implementation PokedexViewController

- (id) init{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        // set up Navigation
        UINavigationItem *n = [self navigationItem];
        [n setTitle:NSLocalizedString(@"Pokédex", @"Name of application")];
        
        // Parse pokemon.csv
        NSString *pokemonPath = [[NSBundle mainBundle] pathForResource:@"pokemon" ofType:@"csv"];
        pokemonList = [NSArray arrayWithContentsOfCSVFile:pokemonPath];
        // Parse other CSV files
        NSString *pTypesPath = [[NSBundle mainBundle] pathForResource:@"pokemon_types" ofType:@"csv"];
        NSString *typesPath = [[NSBundle mainBundle] pathForResource:@"type_names" ofType:@"csv"];
        NSString *descPath = [[NSBundle mainBundle] pathForResource:@"pokemon_species_flavor_text" ofType:@"csv"];
        // Array of Pokemon and their types (as numbers)
        pTypeList = [NSArray arrayWithContentsOfCSVFile:pTypesPath];
        // Array of numbers/names of types
        typeList = [NSArray arrayWithContentsOfCSVFile:typesPath];
        // Array of Pokemon and descriptions
        descList = [NSArray arrayWithContentsOfCSVFile:descPath
                                               options:CHCSVParserOptionsRecognizesBackslashesAsEscapes | CHCSVParserOptionsSanitizesFields];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 151; // Pokedex with 151 Pokemon
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    // Configure the cell with the Pokemon
    
    // Note we use +1 because the 0th entry of pokemonList is the heading
    NSArray *cellPokemon = [pokemonList objectAtIndex:[indexPath row] +1];
    // Capitalize the first letter of the Pokemon
    NSString *pokemonName = [cellPokemon objectAtIndex:1];
    pokemonName = [pokemonName stringByReplacingCharactersInRange:NSMakeRange(0,1)
                                                       withString:[[pokemonName substringToIndex:1] uppercaseString]];
    // Set the cell to display number and name, e.g., 1. Bulbasaur
    [cell.textLabel setText:[NSString stringWithFormat:@"%ld. %@",[indexPath row]+1,pokemonName]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *pnum = [NSNumber numberWithInteger:[indexPath row] + 1]; // Pokemon number
    
    NSArray *pkmnArray = [pokemonList objectAtIndex:[indexPath row] + 1];
    NSString *pname = [pkmnArray objectAtIndex:1];
    pname = [pname stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[pname substringToIndex:1] uppercaseString]];
    
    NSUInteger typeNum = [[[pTypeList objectAtIndex:[indexPath row] + 1] objectAtIndex:1] integerValue];
    NSString *type = [[typeList objectAtIndex:typeNum] objectAtIndex:2];
    
    NSString *pdesc = [[descList objectAtIndex:[indexPath row] + 1] objectAtIndex:3];
    
    NSInteger heightInt = [[pkmnArray objectAtIndex:3] integerValue];
    NSInteger weightInt = [[pkmnArray objectAtIndex:4] integerValue];
    
    // NSURL for the path to the cry file
    NSURL *cryURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@",pnum] ofType:@"wav"]];
    
    NHPokemon *pokemon = [[NHPokemon alloc] initWithName:pname
                                                    type:type
                                                  height:heightInt
                                                  weight:weightInt
                                                  number:pnum
                                             description:pdesc
                                                  sprite:[NSString stringWithFormat:@"%@.png",pnum]
                                                     cry:cryURL];
    PokemonViewController *pvc = [[PokemonViewController alloc] initWithPokemon:pokemon];
    [[self navigationController] pushViewController:pvc animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
