//
//  DataModels.m
//  ondoku
//
//  Created by tobaruhideyasu on 2013/12/08.
//  Copyright (c) 2013年 tobaruhideyasu. All rights reserved.
//

#import "DataModels.h"

#import "FMDatabase.h"
#import "FMResultSet.h"

#define DB_FILE_NAME @"Ondoku.sqlite"

#define SQL_CREATE @"CREATE TABLE IF NOT EXISTS Library (id INTEGER PRIMARY KEY AUTOINCREMENT,title TEXT,contents BLOB,textfield TEXT,read INTEGER,repeat INTEGER,shadow INTEGER)"

#define SQL_INSERT @"INSERT INTO Library (title,textfield,read,repeat,shadow) VALUES (?,?,0,0,0)"
#define SQL_SELECT @"SELECT * FROM Library ORDER BY id DESC"
#define SQL_DROPTABLE @"DELETE FROM Library"
#define SQL_UPDATE @"UPDATE Library SET title=?,textfield=? WHERE id=?"

#define SQL_UPDATE_CNT_READ @"UPDATE Library SET read=read+1 WHERE id=?"
#define SQL_UPDATE_CNT_REPEAT @"UPDATE Library SET repeat=repeat+1 WHERE id=?"
#define SQL_UPDATE_CNT_SHADOW @"UPDATE Library SET shadow=shadow+1 WHERE id=?"


@implementation DataModels


+ (void)insertTitle:(NSString *)title Textfield:(NSString *)textfield
{
    NSArray*    paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString*   dir   = [paths objectAtIndex:0];
    FMDatabase* db    = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:DB_FILE_NAME]];
    
	[db open];
    [db executeUpdate:SQL_CREATE];
    [db executeUpdate:SQL_INSERT,title,textfield];
    [db close];
}

+ (void)updateContents:(NSString *)title Textfield:(NSString *)textfield Id:(NSInteger *)Id
{
    NSArray*    paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString*   dir   = [paths objectAtIndex:0];
    FMDatabase* db    = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:DB_FILE_NAME]];
    
	[db open];
    
    [db executeUpdate:SQL_UPDATE,title,textfield,Id];
    [db close];
}

+ (void)updateCount:(NSInteger *)kind Id:(NSInteger *)Id
{
    NSArray*    paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString*   dir   = [paths objectAtIndex:0];
    FMDatabase* db    = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:DB_FILE_NAME]];
    
	[db open];
    
    NSLog(@"updateCnt->%d",kind);
    
    if( kind == 0)
    {
        [db executeUpdate:SQL_UPDATE_CNT_READ,Id];
    }
    else if( (NSUInteger)kind == 1)
    {
        [db executeUpdate:SQL_UPDATE_CNT_REPEAT,Id];
    }
    else if( (NSUInteger)kind == 2)
    {
        [db executeUpdate:SQL_UPDATE_CNT_SHADOW,Id];
    }
    
    [db close];
}

+ (NSMutableArray *)selectId :(NSMutableArray *)array
{
    NSArray*    paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString*   dir   = [paths objectAtIndex:0];
    FMDatabase* db    = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:DB_FILE_NAME]];
	[db open];
    
	
	FMResultSet*    results = [db executeQuery:SQL_SELECT];
    
    NSString*       idData;
	
	while( [results next] )
	{
		idData = [results stringForColumn:@"id"];
        [array addObject:idData];
	}
	
	[db close];
	
	return array;
}

+ (NSMutableArray *)selectTitle :(NSMutableArray *)array
{
    NSArray*    paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString*   dir   = [paths objectAtIndex:0];
    FMDatabase* db    = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:DB_FILE_NAME]];
	[db open];
    
	
	FMResultSet*    results = [db executeQuery:SQL_SELECT];
    
    NSString*       titleData;
	
	while( [results next] )
	{
		titleData = [results stringForColumn:@"title"];
        [array addObject:titleData];
	}
	
	[db close];
	
	return array;
}

+ (NSMutableArray *)selectContents :(NSMutableArray *)array
{
    NSArray*    paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString*   dir   = [paths objectAtIndex:0];
    FMDatabase* db    = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:DB_FILE_NAME]];
    
	[db open];
	
	FMResultSet*    results = [db executeQuery:SQL_SELECT];
    
    NSData*       contentsData;
	
	while( [results next] )
	{
		contentsData = [results dataForColumn:@"contents"];
        [array addObject:contentsData];
	}
	
	[db close];
	
	return array;
}

+ (NSMutableArray *)selectText :(NSMutableArray *)array
{
    NSArray*    paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString*   dir   = [paths objectAtIndex:0];
    FMDatabase* db    = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:DB_FILE_NAME]];
	[db open];
    
	
	FMResultSet*    results = [db executeQuery:SQL_SELECT];
    
    NSString*       textData;
	
	while( [results next] )
	{
		textData = [results stringForColumn:@"textfield"];
        [array addObject:textData];
	}
	
	[db close];
	
	return array;
}



+ (void)drop_table
{
    NSArray*    paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString*   dir   = [paths objectAtIndex:0];
    FMDatabase* db    = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:DB_FILE_NAME]];
    
    
	[db open];
    [db executeUpdate:SQL_DROPTABLE];
    [db close];
}

+ (NSMutableArray *)selectAll :(NSMutableArray *)result
{
    NSArray*    paths = NSSearchPathForDirectoriesInDomains( NSDocumentDirectory, NSUserDomainMask, YES );
    NSString*   dir   = [paths objectAtIndex:0];
    FMDatabase* db    = [FMDatabase databaseWithPath:[dir stringByAppendingPathComponent:DB_FILE_NAME]];
	[db open];
    
    //結果格納用配列
    //NSMutableArray *result = [[NSMutableArray alloc] init];
    
    //クエリの実行と結果(ResultSet)の取得
    FMResultSet *rs = [db executeQuery:SQL_SELECT];
    
    //結果の取得(indexで取得)
    while ([rs next]) {
        //結果格納用のオブジェクト
    
        NSDictionary *dict =
        [NSDictionary dictionaryWithObjectsAndKeys:
         [rs stringForColumn:@"id"], @"Id",
         [rs stringForColumn:@"title"], @"Title",
         [rs stringForColumn:@"textfield"], @"Text",
         [rs stringForColumn:@"read"], @"Read",
         nil];
        
        [result addObject:dict];
        
    }

    [rs close];
    
    NSLog(@"result-1- = %@", result); //=> []
	NSLog(@"result-1-.count = %d", [result count]); //=> 0
    
	return result;
    
}

@end
