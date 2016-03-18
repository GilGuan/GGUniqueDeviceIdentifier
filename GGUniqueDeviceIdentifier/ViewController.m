//
//  ViewController.m
//  GGUniqueDeviceIdentifier
//
//  Created by Gil on 16/3/8.
//  Copyright © 2016年 GilGuan. All rights reserved.
//

#import "ViewController.h"
#import "UIDevice+GGUniqueDeviceIdentifier.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.label.text = [UIDevice uniqueDeviceIdentifier];
    NSLog(@"uniqueDeviceIdentifier = %@", self.label.text);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
