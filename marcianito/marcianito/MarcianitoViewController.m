//
//  MarcianitoViewController.m
//  marcianito
//
//  Created by Lion User on 23/10/12.
//  Copyright (c) 2012 Lion User. All rights reserved.
//

#import "MarcianitoViewController.h"

@interface MarcianitoViewController ()

@end

@implementation MarcianitoViewController

@synthesize imageToMove;

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
    //Platillo volante para mover con el dedo
    imageToMove = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ufo-brown.png"]];
    imageToMove.frame = CGRectMake(110, 10, 211, 130);
    [self.view addSubview:imageToMove];
    
    [super viewDidLoad];
	
    NSError * error;
    NSString * ruta = [[NSBundle mainBundle] pathForResource:@"sonidoFondo" ofType:@"mp3"];
    
    NSURL * url = [[NSURL alloc] initFileURLWithPath:ruta];
    
    self.reproductor = [[AVAudioPlayer alloc] initWithContentsOfURL:url error: &error];
    
    self.reproductor.pan = 0;
    self.reproductor.volume = 1;
    
    self.reproductor.enableRate = NO; //no ralentiza el audio al comenzar
    self.reproductor.rate = 0;
    
    [self.reproductor play];
    [self.reproductor setNumberOfLoops:-1];//el valor -1 indica que la repetición del bucle de sonido será infinita.
    
   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Salto

-(IBAction)alien:(id)sender{
    
    SystemSoundID soundID;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"saltito" ofType:@"mp3"];
    
    AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)[NSURL fileURLWithPath:path],&soundID);
    
    AudioServicesPlaySystemSound (soundID);
    
    [UIView animateWithDuration:0.5 animations:^(void){
        
        //alienProp hace referencia al alien que actúa como botón
        self.alienProp.center = CGPointMake(self.alienProp.center.x , self.alienProp.center.y -50);
        
    }
                     completion:^(BOOL Finished){
                         
                         [self baja];//llamo a baja donde hace lo contrario que el código de subida.
                         
                         
                     }
     
     ];
}

- (void)baja{
    
    [UIView animateWithDuration:0.5 animations:^(void){
        
        self.alienProp.center = CGPointMake(self.alienProp.center.x , self.alienProp.center.y +50);
        
    }
                     completion:nil //ya ha llegado abajo así que me quedo nulo
     ];
}

#pragma mark - Movimiento Touch

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self.view];
    imageToMove.center = location;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self touchesBegan:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}

#pragma mark - Movimiento curvo




@end
