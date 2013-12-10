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
    NSMutableArray *contentsArray;
    
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
    
    
    contentsArray  = [[NSMutableArray alloc] init];
    
    [DataModels selectAll:contentsArray];
    
    
    // 前のTableViewで選択した行に応じて表示させる（セットされたrow_numをここで使う）
    titleLabel.text = [[contentsArray objectAtIndex:row_num] objectForKey:@"Title"];
    textField.text = [[contentsArray objectAtIndex:row_num] objectForKey:@"Text"];
    
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
    
    [DataModels updateCount:(NSInteger)sender.tag Id:(NSInteger)[[contentsArray objectAtIndex:row_num] objectForKey:@"Id"]];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
