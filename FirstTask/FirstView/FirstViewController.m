//
//  FirstViewController.m
//  FirstTask
//
//  Created by Joy on 10/9/18.
//  Copyright © 2018 Joy. All rights reserved.
//

#import "FirstViewController.h"


@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *docsdir;
    NSArray *dirPaths;
    
    //Get the directory
    dirPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    docsdir=dirPaths[0];
    
    //Build the path to keep the database
    _databasePath= [[NSString alloc] initWithString:[docsdir stringByAppendingString:@"myDB.db"]];
    
    NSFileManager *filemgr=[NSFileManager defaultManager];
    
    if([filemgr fileExistsAtPath:_databasePath]==NO){
        const char *dbPath=[_databasePath UTF8String];
        
        if(sqlite3_open(dbPath, &_DB)==SQLITE_OK){
            char *errorMessage;
            const char *sql_statement="CREATE TABLE IF NOT EXISTS user (ID INTEGER PRIMARY KEY AUTOINCREMENT,NAME TEXT)";
            
            if(sqlite3_exec(_DB, sql_statement, NULL, NULL, &errorMessage)!=SQLITE_OK){
                [self showUIAlertWithMessage:@"Failed to Create the table" andTitle:@"Error"];
            }
            sqlite3_close(_DB);
        }else{
            [self showUIAlertWithMessage:@"Failed to open/create table" andTitle:@"Error"];
        }
    }
}

-(void) showUIAlertWithMessage:(NSString*)message 	andTitle:(NSString*)title{
    /*UIAlertView *alert=[[UIAlertView alloc] initWithTitle:title
                                                  message:message
                                                 delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil,nil];*/
    UIAlertController *alertController=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert ];
    UIAlertAction *cancel=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancel];
    [self presentViewController:alertController animated:YES completion:nil];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)submitToDatabase:(id)sender {
    sqlite3_stmt *stmt;
    const char *dbpath=[_databasePath UTF8String];
    if(sqlite3_open(dbpath, &_DB)==SQLITE_OK){
        NSString *insertSQL=[NSString stringWithFormat:@"INSERT INTO user (name) VALUES (\"%@\")",_myTextbox.text];
        const char *insert_stetment=[insertSQL UTF8String];
        sqlite3_prepare(_DB, insert_stetment, -1, &stmt, NULL);
        if(sqlite3_step(stmt)==SQLITE_DONE){
            [self showUIAlertWithMessage:@"User add to database " andTitle:@"Message"];
            _myTextbox.text=@"";
        }else{
            [self showUIAlertWithMessage:@"Failed to add the user" andTitle:@"Error"];
        }
        sqlite3_close(_DB);
    }
}
@end
