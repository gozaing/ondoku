//
//  EditViewController.m
//  ondoku
//
//  Created by tobaruhideyasu on 2013/12/08.
//  Copyright (c) 2013年 tobaruhideyasu. All rights reserved.
//

#import "EditViewController.h"
#import "DataModels.h"

@interface EditViewController ()

@end

@implementation EditViewController
{
@private
    NSMutableArray *titleArry;
    NSMutableArray *contentsArry;
    NSMutableArray *textArry;
    NSMutableArray *idArry;
    
}

@synthesize memofield;
@synthesize textfield;
@synthesize row_num_2;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    titleArry = [[NSMutableArray alloc] init ];
    contentsArry = [[NSMutableArray alloc] init ];
    textArry = [[NSMutableArray alloc] init];
    idArry  = [[NSMutableArray alloc] init];
    
    [DataModels selectTitle:titleArry]; //titleArryにtitleカラムのデータを格納する
    [DataModels selectText:textArry]; //textArryにtextfieldカラムのデータを格納
    [DataModels selectId:idArry]; //unique id column

    // 前のTableViewで選択した行に応じて表示させる（セットされたrow_numをここで使う）
    memofield.text = [titleArry objectAtIndex:row_num_2];
    //photoImage.image = [[UIImage alloc] initWithData:[contentsArry objectAtIndex:row_num]];
    textfield.text = [textArry objectAtIndex:row_num_2];
    
    NSLog(@"rownum-%d",row_num_2);
    NSLog(@"rownum-id-%@",[idArry objectAtIndex:row_num_2]);
    
    //save button set
    // 右上の「Save」ボタン。押したら、save_memo_photoメソッドが実行される
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(mod_memo)];
    self.navigationItem.rightBarButtonItem = button;
    
    
    
}

- (void)mod_memo
{
    // メモ、写真を選択してないと進めない
    if ([memofield.text length] > 0 && [textfield.text length] > 0) {
        
        //update
        [DataModels updateContents:memofield.text Textfield:textfield.text Id:(NSUInteger)[idArry objectAtIndex:row_num_2]];
        
        [self.navigationController popToRootViewControllerAnimated:YES];  //NavigationControllerのホームに戻る
        
    }else { // メモが書かれていない、あるいは写真が選択されていないとアラート
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"写真とメモ" message:@"写真を選んでメモを書いてね" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [av show];
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
