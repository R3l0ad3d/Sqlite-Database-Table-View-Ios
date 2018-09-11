//
//  Database.h
//  FirstTask
//
//  Created by Joy on 11/9/18.
//  Copyright © 2018 Joy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
@interface Database : NSObject
@property (strong,nonatomic) NSString *databasePath;
@property (nonatomic) sqlite3 *DB;

-(BOOL) isDatabaseExist;
-(BOOL) createDatabase;
-(BOOL) addDataToDatabase:(NSString *)name;
-(BOOL) removeDataFromDatabaseById:(long *)id;
-(BOOL) removeDataFromDatabaseByName:(NSString *)name;
-(NSMutableArray*) getAllDataFromDatabase;
@end
