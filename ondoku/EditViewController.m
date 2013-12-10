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
    NSMutableArray *contentsArray;

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
    
    contentsArray = [[NSMutableArray alloc] init];
    
    [DataModels selectAll:contentsArray];
    
    // 前のTableViewで選択した行に応じて表示させる（セットされたrow_numをここで使う）
    memofield.text = [[contentsArray objectAtIndex:row_num_2] objectForKey:@"Title"];
    textfield.text = [[contentsArray objectAtIndex:row_num_2] objectForKey:@"Text"];
    
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
        [DataModels updateContents:memofield.text Textfield:textfield.text Id:(NSUInteger)[[contentsArray objectAtIndex:row_num_2] objectForKey:@"Id"]];
        
        [self.navigationController popToRootViewControllerAnimated:YES];  //NavigationControllerのホームに戻る
        
    }else { // メモが書かれていない、あるいは写真が選択されていないとアラート
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"メモ" message:@"メモを書く" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [av show];
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
