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

// 2013/12/11
@property(nonatomic, strong) UITapGestureRecognizer *singleTap;

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
    
    //2013/12/11
    //add gesture
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTap:)];
    self.singleTap.delegate = self;
    self.singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:self.singleTap];
    
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

-(void)onSingleTap:(UITapGestureRecognizer *)recognizer {
    [self.textField resignFirstResponder];
}

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (gestureRecognizer == self.singleTap) {
        // キーボード表示中のみ有効
        if (self.textField.isFirstResponder) {
            return YES;
        } else {
            return NO;
        }
    }
    return YES;
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
