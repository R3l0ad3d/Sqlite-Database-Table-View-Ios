//
//  Database.m
//  FirstTask
//
//  Created by Joy on 11/9/18.
//  Copyright © 2018 Joy. All rights reserved.
//

#import "Database.h"

@interface Database()

@end

@implementation Database
- (instancetype)init
{
    self = [super init];
    if (self) {
        NSString *docsdir;
        NSArray *dirPaths;
        
        //Get the directory
        dirPaths=NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        docsdir=dirPaths[0];
        
        //Build the path to keep the database
        _databasePath= [[NSString alloc] initWithString:[docsdir stringByAppendingString:@"myDB.db"]];
    }
    return self;
}
- (BOOL)isDatabaseExist{
    
    
    NSFileManager *filemgr=[NSFileManager defaultManager];
    
    if([filemgr fileExistsAtPath:_databasePath]==NO){
        return NO;
    }else return YES;
}
- (BOOL)createDatabase{
    BOOL flag;
    const char *dbPath=[_databasePath UTF8String];
    
    if(sqlite3_open(dbPath, &_DB)==SQLITE_OK){
        char *errorMessage;
        const char *sql_statement="CREATE TABLE IF NOT EXISTS user (ID INTEGER PRIMARY KEY AUTOINCREMENT,NAME TEXT)";
        
        if(sqlite3_exec(_DB, sql_statement, NULL, NULL, &errorMessage)!=SQLITE_OK){
            flag=NO;
        }else{
            flag=true;
        }
        sqlite3_close(_DB);
    }else{
        flag=NO;
    }
    return flag;
}
- (BOOL)addDataToDatabase:(NSString *)name{
    BOOL flag;
    sqlite3_stmt *stmt;
    const char *dbpath=[_databasePath UTF8String];
    if(sqlite3_open(dbpath, &_DB)==SQLITE_OK){
        NSString *insertSQL=[NSString stringWithFormat:@"INSERT INTO user (name) VALUES (\"%@\")",name];
        const char *insert_stetment=[insertSQL UTF8String];
        sqlite3_prepare(_DB, insert_stetment, -1, &stmt, NULL);
        if(sqlite3_step(stmt)==SQLITE_DONE){
            flag=true;
        }else{
            flag=false;
        }
        sqlite3_close(_DB);
    }else{
        flag=false;
    }
    return flag;
}

- (BOOL)removeDataFromDatabaseById:(long *)id{
    BOOL flag;
    char *errorMessage;
    const char *dbpath=[_databasePath UTF8String];
    if(sqlite3_open(dbpath, &_DB)==SQLITE_OK){
        NSString *delete_quary=[NSString stringWithFormat:@"Delete from user where ID= %ld",(long)id];
        const char *deleteQuary=[delete_quary UTF8String];
        if(sqlite3_exec(_DB, deleteQuary, NULL, NULL, &errorMessage)==SQLITE_OK){
            flag=YES;
            
        }else{
            flag=NO;
        }
        
    }else{
        flag=NO;
    }
    return flag;
}
- (BOOL)removeDataFromDatabaseByName:(NSString *)name{
    BOOL flag;
    char *errorMessage;
    const char *dbpath=[_databasePath UTF8String];
    if(sqlite3_open(dbpath, &_DB)==SQLITE_OK){
        NSString *delete_quary=[NSString stringWithFormat:@"Delete from user where NAME= \"%@\"",name];
        const char *deleteQuary=[delete_quary UTF8String];
        if(sqlite3_exec(_DB, deleteQuary, NULL, NULL, &errorMessage)==SQLITE_OK){
            flag=YES;
            
        }else{
            flag=NO;
        }
        
    }else{
        flag=NO;
    }
    return flag;
}
- (NSMutableArray *)getAllDataFromDatabase{
    NSMutableArray *array=[[NSMutableArray alloc] init ];
    sqlite3_stmt *statment;
    const char *dbpath=[_databasePath UTF8String];
    if(sqlite3_open(dbpath, &_DB)==SQLITE_OK){
        NSString *quaryStatement=@"Select * from user";
        
        const char *quary=[quaryStatement UTF8String];
        
        if(sqlite3_prepare_v2(_DB,quary, -1, &statment, NULL)==SQLITE_OK){
            while (sqlite3_step(statment)==SQLITE_ROW) {
                NSString *name=[[NSString alloc] initWithUTF8String:(const char *) sqlite3_column_text(statment,1)];
                [array addObject:name];
                
            }
        }
        sqlite3_close(_DB);
    }
    return array;
    
}
@end
