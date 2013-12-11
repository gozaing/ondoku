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

// 2013/12/11
@property(nonatomic, strong) UITapGestureRecognizer *singleTap;


@end

@implementation EditViewController
{
@private
    NSMutableArray *contentsArray;

}

@synthesize memofield;
@synthesize textfield;
@synthesize row_num_2;

@synthesize countText;

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
    
    //2013/12/11
    //add gesture
    self.singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onSingleTap:)];
    self.singleTap.delegate = self;
    self.singleTap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:self.singleTap];
    
    picker = [[UIPickerView alloc] init];
    picker.frame = CGRectMake(0, 420, 320, 216);
    picker.showsSelectionIndicator = YES;
    picker.delegate = self;
    picker.dataSource = self;
    [self.view addSubview:picker];
    
    countText.delegate = self;
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //テキストフィールドの編集を始めるときに、ピッカーを呼び出す。
    [self showPicker];
    
    //キーボードは表示させない
    return NO;
}

- (void)showPicker {
	//ピッカーが下から出るアニメーション
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationDelegate:self];
	picker.frame = CGRectMake(0, 204, 320, 216);
	[UIView commitAnimations];
	
	//ナビゲーションバーの右上にdoneボタンを設置する
	/*
    if (!self.navigationItem.rightBarButtonItem) {
        UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done:)];
        [self.navigationItem setRightBarButtonItem:done animated:YES];
    }
     */
}

/*
- (void)done:(id)sender {
	//ピッカーをしまう
	[self hidePicker];
	
	//doneボタンを消す
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
}
*/


- (void)mod_memo
{
    // メモ、写真を選択してないと進めない
    if ([memofield.text length] > 0 && [textfield.text length] > 0) {
        
        //update
        [DataModels updateContents:memofield.text Textfield:textfield.text Id:(NSUInteger)[[contentsArray objectAtIndex:row_num_2] objectForKey:@"Id"]];
        
        
        //hide picker
        //ピッカーをしまう
        //[self hidePicker];
        
        [self.navigationController popToRootViewControllerAnimated:YES];  //NavigationControllerのホームに戻る
        
        
        
    }else { // メモが書かれていない、あるいは写真が選択されていないとアラート
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"メモ" message:@"メモを書く" delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [av show];
    }
}

/*
- (void)hidePicker {
	//ピッカーを下に隠すアニメーション
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.2];
	[UIView setAnimationDelegate:self];
	picker.frame = CGRectMake(0, 420, 320, 216);
	[UIView commitAnimations];
}
*/

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 100;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%d",row];
}
- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    countText.text = [NSString stringWithFormat:@"%d",row];
}



-(void)onSingleTap:(UITapGestureRecognizer *)recognizer {
    [self.textfield resignFirstResponder];
}

-(BOOL) gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (gestureRecognizer == self.singleTap) {
        // キーボード表示中のみ有効
        if (self.textfield.isFirstResponder) {
            return YES;
        } else {
            return NO;
        }
    }
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
