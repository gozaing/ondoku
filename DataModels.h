//
//  DataModels.h
//  ondoku
//
//  Created by tobaruhideyasu on 2013/12/08.
//  Copyright (c) 2013年 tobaruhideyasu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataModels : NSObject

+ (void)insertTitle:(NSString *)title Textfield:(NSString *)textfiled;

+ (void)updateContents:(NSString *)title Textfield:(NSString *)textfiled Id:(NSInteger *)Id;
+ (void)updateCount:(NSInteger *)kind Id:(NSInteger *)Id;

+ (NSMutableArray *)selectId:(NSMutableArray *)array;
+ (NSMutableArray *)selectTitle:(NSMutableArray *)array;
+ (NSMutableArray *)selectContents:(NSMutableArray *)array;
+ (NSMutableArray *)selectText:(NSMutableArray *)array;
+ (void)drop_table;
+ (NSMutableArray *)selectAll:(NSMutableArray *)array;

@end
