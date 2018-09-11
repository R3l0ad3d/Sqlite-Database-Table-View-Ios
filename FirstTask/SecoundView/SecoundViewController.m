//
//  SecoundViewController.m
//  FirstTask
//
//  Created by Joy on 11/9/18.
//  Copyright © 2018 Joy. All rights reserved.
//

#import "SecoundViewController.h"
#import "TableViewCell.h"

@interface SecoundViewController ()

@end

@implementation SecoundViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Boolean flag=true;
    _array=[[NSMutableArray alloc] init];
    
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
                //database error
                flag=false;
                [self showUIAlertWithMessage:@"Failed to Create the table" andTitle:@"Error"];
            }
            sqlite3_close(_DB);
        }else{
            //database error
            flag=false;
            [self showUIAlertWithMessage:@"Failed to open/create table" andTitle:@"Error"];
        }
    }
    if(flag){
        sqlite3_stmt *statment;
        const char *dbpath=[_databasePath UTF8String];
        if(sqlite3_open(dbpath, &_DB)==SQLITE_OK){
            NSString *quaryStatement=@"Select * from user";
            
            const char *quary=[quaryStatement UTF8String];
            
            if(sqlite3_prepare_v2(_DB,quary, -1, &statment, NULL)==SQLITE_OK){
                while (sqlite3_step(statment)==SQLITE_ROW) {
                    NSString *name=[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statment,1)];
                    [_array addObject:name];
                    
                }
            }
            sqlite3_close(_DB);
        }
        
        
    }
}

-(void) deleteRow:(id) sender{
    UIButton *button=(UIButton *)sender;
    NSLog(@"Button tapped %ld",button.tag);
    NSString *name=_array[button.tag];
    char *errorMessage;
    const char *dbpath=[_databasePath UTF8String];
    if(sqlite3_open(dbpath, &_DB)==SQLITE_OK){
        NSString *delete_quary=[NSString stringWithFormat:@"Delete from user where NAME= \"%@\"",name];
        const char *deleteQuary=[delete_quary UTF8String];
        if(sqlite3_exec(_DB, deleteQuary, NULL, NULL, &errorMessage)==SQLITE_OK){
            [self showUIAlertWithMessage:@"Delete item" andTitle:@"Message"];
            
            [_array removeObjectAtIndex:button.tag];
            [self.tableView reloadData];
            
        }else{
            [self showUIAlertWithMessage:@"Failed to delete data" andTitle:@"Error"];
        }
        
    }else{
        [self showUIAlertWithMessage:@"Failed to delete data" andTitle:@"Error"];
    }
}

-(void) showUIAlertWithMessage:(NSString*)message     andTitle:(NSString*)title{
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    cell.myLabel.text=_array[indexPath.row];
    cell.btnDelete.tag=indexPath.row;
    [cell.btnDelete addTarget:self action:@selector(deleteRow:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
