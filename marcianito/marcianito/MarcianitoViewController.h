//
//  MarcianitoViewController.h
//  marcianito
//
//  Created by Lion User on 23/10/12.
//  Copyright (c) 2012 Lion User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>


@interface MarcianitoViewController : UIViewController{
    IBOutlet UIImageView *ufoImageView;
    IBOutlet UIImageView *ufoRayImageView;
    IBOutlet UIButton *alienProp;
    //IBOutlet UIImageView *imageView;
}


@property (nonatomic, strong) AVAudioPlayer * reproductor;
@property (nonatomic, strong) AVAudioPlayer * reproductorGrillos;
@property (nonatomic, strong) IBOutlet UIImageView *imageView;
//@property (nonatomic, strong) IBOutlet UIButton *alienProp;

-(IBAction)alien:(id)sender;

@end
