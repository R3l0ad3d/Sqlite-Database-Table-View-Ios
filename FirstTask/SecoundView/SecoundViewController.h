//
//  SecoundViewController.h
//  FirstTask
//
//  Created by Joy on 11/9/18.
//  Copyright © 2018 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface SecoundViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
    @property NSMutableArray *array;
    //property
    @property (strong,nonatomic) NSString *databasePath;
    @property (nonatomic) sqlite3 *DB;
@end
