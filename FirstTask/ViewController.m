//
//  ViewController.m
//  FirstTask
//
//  Created by Joy on 10/9/18.
//  Copyright © 2018 Joy. All rights reserved.
//

#import "ViewController.h"
#import "FirstView/FirstViewController.h"
#import "SecoundView/SecoundViewController.h"
#import "ThirdView/ThirdViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)firstButtonClick:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FirstViewController *viewController = (FirstViewController* )[storyboard instantiateViewControllerWithIdentifier:@"FirstView"];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (IBAction)secoundButtonClick:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SecoundViewController *viewController = (SecoundViewController* )[storyboard instantiateViewControllerWithIdentifier:@"SecoundView"];
    [self.navigationController pushViewController:viewController animated:YES];
}
- (IBAction)thirdButtonClick:(id)sender {
    UIStoryboard *storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ThirdViewController *viewController = (ThirdViewController* )[storyboard instantiateViewControllerWithIdentifier:@"ThirdView"];
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
