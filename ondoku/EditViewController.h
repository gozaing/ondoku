//
//  EditViewController.h
//  ondoku
//
//  Created by tobaruhideyasu on 2013/12/08.
//  Copyright (c) 2013年 tobaruhideyasu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController <UITextFieldDelegate, UIGestureRecognizerDelegate,UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView *picker;
}
@property (nonatomic,assign) NSInteger row_num_2; //<-この使い方不明
@property (weak, nonatomic) IBOutlet UITextField *memofield;
@property (weak, nonatomic) IBOutlet UITextView *textfield;

@property (weak, nonatomic) IBOutlet UITextField *countText;

@end
