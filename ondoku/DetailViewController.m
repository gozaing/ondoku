//
//  DetailViewController.m
//  ondoku
//
//  Created by tobaruhideyasu on 2013/12/08.
//  Copyright (c) 2013年 tobaruhideyasu. All rights reserved.
//

#import "DetailViewController.h"
#import "DataModels.h"
#import "EditViewController.h"


@interface DetailViewController ()

@end

@implementation DetailViewController
{
@private
    NSMutableArray *titleArry;
    NSMutableArray *contentsArry;
    NSMutableArray *textArry;
    NSMutableArray *idArry;
}

@synthesize row_num;
@synthesize titleLabel;
@synthesize textField;


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
    textArry = [[NSMutableArray alloc] init];
    idArry  = [[NSMutableArray alloc] init];
    
    [DataModels selectTitle:titleArry]; //titleArryにtitleカラムのデータを格納する
    [DataModels selectText:textArry]; //textArryにtextfieldカラムのデータを格納
    [DataModels selectId:idArry]; //unique id column
    
    // 前のTableViewで選択した行に応じて表示させる（セットされたrow_numをここで使う）
    titleLabel.text = [titleArry objectAtIndex:row_num];
    textField.text = [textArry objectAtIndex:row_num];
    
    // 右上の「Save」ボタン。押したら、save_memo_photoメソッドが実行される
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit target:self action:@selector(mod_text)];
    self.navigationItem.rightBarButtonItem = button;
    
}

- (void)mod_text
{
    NSLog(@"mod-text-start");
    
    
    EditViewController *evc = [[EditViewController alloc] initWithNibName:@"EditViewController" bundle:nil];
    
    evc.row_num_2 = row_num;
    
    [self.navigationController pushViewController:evc animated:YES];
    
}


- (IBAction)countUpDidPush:(UIButton *)sender {
    
    NSLog(@"countUpDidPush->%d",sender.tag);
    //[DataModels updateCount:aa Id:[idArry objectAtIndex:row_num]];
    [DataModels updateCount:(NSInteger)sender.tag Id:(NSInteger)[idArry objectAtIndex:row_num]];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
