//
//  NewViewController.m
//  ondoku
//
//  Created by tobaruhideyasu on 2013/12/08.
//  Copyright (c) 2013年 tobaruhideyasu. All rights reserved.
//

#import "NewViewController.h"
#import "DataModels.h"


@interface NewViewController ()

@end

@implementation NewViewController
{
//↓追加
//@private NSData *imageData;
}
@synthesize titleField;
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
    
    // 右上の「Save」ボタン。押したら、save_memo_photoメソッドが実行される
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(save_memo_photo)];
    
    self.navigationItem.rightBarButtonItem = button;
    
    titleField.delegate = self; //<-追加
}

- (void)save_memo_photo
{
    // メモ、写真を選択してないと進めない
    if ( [titleField.text length] > 0 ) {
        
        [DataModels insertTitle:titleField.text Textfield:textField.text]; //DataModelsクラスのクラスメソッド
        
        [self.navigationController popToRootViewControllerAnimated:YES];  //NavigationControllerのホームに戻る
        
    }else { // メモが書かれていない、あるいは写真が選択されていないとアラート
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"メモ" message:@"メモを書いて" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [av show];
    }
}



-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [titleField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
