//
//  ViewController.m
//  ondoku
//
//  Created by tobaruhideyasu on 2013/12/08.
//  Copyright (c) 2013年 tobaruhideyasu. All rights reserved.
//

#import "ViewController.h"
#import "NewViewController.h"  //add
#import "DataModels.h"
#import "DetailViewController.h"


@interface ViewController ()

// 別クラスとアクセスはしないので、プラベートに宣言
@property (retain, nonatomic) UITableView *tableView;

@end

@implementation ViewController
{
    @private
    NSMutableArray *contentsArray;

}
@synthesize tableView = _tableView; //<-synthesizeして、ゲッターとセッターを生成

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"List"; //タイトル名
    self.navigationController.navigationBar.tintColor = [UIColor blackColor]; //ナビゲーションバーを黒に
    // ナビゲーションバーのボタン。プラスボタンにして、押したときにはmake_new_contentsメソッドが実行される。
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(make_new_contents)];
    self.navigationItem.rightBarButtonItem = button; //右側に設置。左ならleftBartButtonItem
    
    
    /*---TableViewの設置---*/
    _tableView = [[UITableView alloc] init];
//    _tableView.frame = CGRectMake(0, 0, 320, 460-44); //TableViewの大きさ
    _tableView.frame = CGRectMake(0, 60, 320, 460-44); //TableViewの大きさ
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.rowHeight = 50.0; // セルの高さ
    [self.view addSubview:_tableView];

    
    
}

// Viewが呼ばれるたびにデータとテーブルの更新
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    contentsArray = [[NSMutableArray alloc] init ]; //画像を格納するための可変配列
    [DataModels selectAll:contentsArray];
    
    [_tableView reloadData]; //テーブルをリロードして更新
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return contentsArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] ;
    }
    
    //セルに表示する内容
    //cell.textLabel.text = [titleArry objectAtIndex:indexPath.row];

    cell.textLabel.text = [[contentsArray objectAtIndex:indexPath.row] objectForKey:@"Title"];
    
 
    
    
    NSLog(@"test-id-%@",[[contentsArray objectAtIndex:indexPath.row] objectForKey:@"Id"]);
    NSLog(@"test-title-%@",[[contentsArray objectAtIndex:indexPath.row] objectForKey:@"Title"]);
    NSLog(@"test-text-%@",[[contentsArray objectAtIndex:indexPath.row] objectForKey:@"Text"]);
    NSLog(@"test-read-%@",[[contentsArray objectAtIndex:indexPath.row] objectForKey:@"Read"]);
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // セルの選択を解除する
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    for (int i = 0; i < contentsArray.count; i++) {
        if (indexPath.row == i) {
            DetailViewController *dvc = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
            dvc.row_num = i; // どの行を選んだのか、次のViewControllerに値を受け渡ししている。
            [self.navigationController pushViewController:dvc animated:YES];
        }
    }
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if( editingStyle == UITableViewCellEditingStyleDelete )
	{
		[self removeContents:indexPath];
	}
}

- (void)removeContents:(NSIndexPath*)indexPath
{
    //選択したrow番目の配列要素を削除する。
    NSInteger row = [indexPath row];
    [contentsArray removeObjectAtIndex: row];
    
    //セルが消えるアニメーション
    [_tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]  withRowAnimation:UITableViewRowAnimationFade];
    
    
    //いったん、テーブルの中身を削除してしまう。
    [DataModels drop_table];
    
    //titleArryとcontentsArryは、すでに要素が削除されていて、残りの要素がつめられている状態。そしてインサートしている。
    for (int i = 0; i < contentsArray.count; i++ ) {
        [DataModels insertTitle:[contentsArray objectAtIndex:i] Textfield:@"aa"];
    }
}

/*ナビゲーションバーの右のボタンが押されたら、画面遷移*/
- (void)make_new_contents
{
    NewViewController *nvc = [[NewViewController alloc] initWithNibName:@"NewViewController" bundle:nil];
    [self.navigationController pushViewController:nvc animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
