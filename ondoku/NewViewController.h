//
//  NewViewController.h
//  ondoku
//
//  Created by tobaruhideyasu on 2013/12/08.
//  Copyright (c) 2013年 tobaruhideyasu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewViewController : UIViewController <UIActionSheetDelegate,UITextFieldDelegate> //<-宣言


@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *textField;


@end
