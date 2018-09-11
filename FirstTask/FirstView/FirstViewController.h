//
//  FirstViewController.h
//  FirstTask
//
//  Created by Joy on 10/9/18.
//  Copyright © 2018 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
#import "Database.h"
@interface FirstViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *myTextbox;
- (IBAction)submitToDatabase:(id)sender;
//property
@property (strong,nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *DB;
@property Database *db;
@end
