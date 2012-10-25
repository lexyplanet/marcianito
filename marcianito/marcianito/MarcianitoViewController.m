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
-(id)init{
    if((self!=[super init])){
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

//evento que al tocar la pantalla se ejecuta
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //Instancio una variable CGRect para poder obtener los atributos de UIImagenView de los rayos
    CGRect frame=ufoRayImageView.frame;
    frame.size.height=0; // aqui le digo que el ancho sea 0 para que desaparesca.
    ufoRayImageView.frame=frame; //aqui le asigno frame a los rayos.
    UITouch *touch=[[event allTouches] anyObject]; //con este objeto le indico que acceda al touch
    CGPoint location =[touch locationInView:touch.view]; //localizo en donde doy touch del UIViewController
    ufoImageView.center= location; //Le asigno a la imagen del platillo volarod la localizacion
}

//Evento que al dejar de tocar se ejecuta
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    int minX=0;
    int maxX=260;
    //Nuevos parametros de localizacion para los rayos de la nave.
    CGRect Rayos=ufoRayImageView.frame;
    Rayos.origin.x = ufoImageView.frame.origin.x-25;
    Rayos.origin.y = ufoImageView.frame.origin.y+65;
    
    CGRect frameMarcianito= alienProp.frame; // obtener las propiedades del alien.
    
    if((Rayos.origin.x>=frameMarcianito.origin.x-90 && Rayos.origin.x<=frameMarcianito.origin.x) && frameMarcianito.origin.y<Rayos.origin.y+30){
        
        SystemSoundID soundRayoID;
        NSString *pathRayo = [[NSBundle mainBundle] pathForResource:@"lazer1" ofType:@"mp3"];
        
        AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)[NSURL fileURLWithPath:pathRayo],&soundRayoID);
        
        AudioServicesPlaySystemSound (soundRayoID);
        
        Rayos.size.height=100;
        int xMarcianito;
        
        xMarcianito=random()%260; // Hago un random para hacer una localización diferente del alien.
        
        if((xMarcianito>=alienProp.frame.origin.x) && (xMarcianito-67<=alienProp.frame.origin.x)){
            xMarcianito=xMarcianito+67;
            xMarcianito=random()%xMarcianito;
            if((xMarcianito>=alienProp.frame.origin.x) && (xMarcianito-67<=alienProp.frame.origin.x)){
                xMarcianito=xMarcianito+70;
            }
        }
        else{
            xMarcianito=xMarcianito-67;
            if((xMarcianito>=alienProp.frame.origin.x) && (xMarcianito-67<=alienProp.frame.origin.x)){
                xMarcianito=xMarcianito+67+50;
            }
        }
        
        
        if(xMarcianito<0)
            xMarcianito=maxX;
        else if(xMarcianito>260)
            xMarcianito=minX;
        
        CGRect alien=alienProp.frame;
        alien.origin.x =  xMarcianito;
        alienProp.frame=alien; // le asigno los nuevos datos al alien.
        //Sonido de rayo
        
        //Sonido de Teletransporte
        SystemSoundID soundTeletransporteID;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"teletransporte1" ofType:@"mp3"];
        
        AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)[NSURL fileURLWithPath:path],&soundTeletransporteID);
        
        AudioServicesPlaySystemSound (soundTeletransporteID);
        
    }
    else{
        
    }
    ufoRayImageView.frame=Rayos; // le asigno los nuevos datos a los rayos
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [self touchesBegan:touches withEvent:event];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    NSArray *images = [NSArray arrayWithObjects:[UIImage imageNamed:@"fondo_1.png"],[UIImage imageNamed:@"fondo_2.png"],nil];
    self.imageView.animationImages = images;
    self.imageView.animationDuration =1;
    [self.imageView startAnimating];
    
	NSError * error;
    NSString * ruta = [[NSBundle mainBundle] pathForResource:@"sonidoFondo" ofType:@"mp3"];
    
    NSURL * url = [[NSURL alloc] initFileURLWithPath:ruta];
    
    
    NSString * rutaGrillos = [[NSBundle mainBundle] pathForResource:@"grillos1" ofType:@"mp3"];
    
    NSURL * urlGrillos = [[NSURL alloc] initFileURLWithPath:rutaGrillos];
    
    
    //Fondo
    self.reproductor = [[AVAudioPlayer alloc] initWithContentsOfURL:url error: &error];
    
    self.reproductor.pan = 0;
    self.reproductor.volume = 2;
    
    self.reproductor.enableRate = NO; //no ralentiza el audio al comenzar
    self.reproductor.rate = 0;
    
    [self.reproductor play];
    [self.reproductor setNumberOfLoops:-1];//el valor -1 indica que la repetición del bucle de sonido será infinita.
    
    //Grillos
    self.reproductorGrillos = [[AVAudioPlayer alloc] initWithContentsOfURL:urlGrillos error: &error];
    
    self.reproductorGrillos.pan = 0;
    self.reproductorGrillos.volume = .1;
    
    self.reproductorGrillos.enableRate = NO; //no ralentiza el audio al comenzar
    self.reproductorGrillos.rate = 0;
    
    [self.reproductorGrillos play];
    [self.reproductorGrillos setNumberOfLoops:-1];
}

/*
 -(void)changeImage{
 [imageView performSelectorOnMainThread:@selector(setImage:) withObject:[UIImage imageNamed:@"fondo_2.png"] waitUntilDone:TRUE];
 }
 */
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
        alienProp.center = CGPointMake(alienProp.center.x , alienProp.center.y -50);
        
    }
                     completion:^(BOOL Finished){
                         
                         [self baja];//llamo a baja donde hace lo contrario que el código de subida.
                         
                         
                     }
     
     ];
    
}
- (void)baja{
    
    [UIView animateWithDuration:0.5 animations:^(void){
        
        alienProp.center = CGPointMake(alienProp.center.x , alienProp.center.y +50);
        
    }
                     completion:nil //ya ha llegado abajo así que me quedo nulo
     ];
    
}

@end