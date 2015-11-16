//
//  GlobelTicketTableViewController.m
//  MengJingMovie
//
//  Created by mengjing on 15/10/27.
//  Copyright (c) 2015年 mengjing. All rights reserved.
//

#import "GlobelTicketTableViewController.h"

#import "FindNewsDetailTopTableViewCell.h"

@interface GlobelTicketTableViewController ()

@property(nonatomic, strong)NSMutableArray * modelsArray;

@end

@implementation GlobelTicketTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self parserURL];
    [self Register];
  
}
//注册
- (void)Register {
    
    UINib * nib = [UINib nibWithNibName:@"FindNewsDetailTopTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"findCNCell_id"];
}
//数据解析
- (void)parserURL{
    
    NSURL * url = [NSURL URLWithString:kGlobelTicket(self.columnId)];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if (data != nil) {
            
            [[ShareAnimationLoad ShareAnimation]animationSuccessLoad];
            self.modelsArray = [NSMutableArray array];
            NSMutableDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:nil];
            
            NSArray * array = dic[@"movies"];
            
            for (NSDictionary * dict in array) {
                
                FindModel * model = [[FindModel alloc]init];
                [model setValuesForKeysWithDictionary:dict];
                [self.modelsArray addObject:model];
                //NSLog(@"========%@",self.modelsArray);
            }
        }
        [self.tableView reloadData];

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return self.modelsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FindNewsDetailTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"findCNCell_id" forIndexPath:indexPath];
    
    FindModel * model = self.modelsArray[indexPath.row];
    
    [cell fetchdataWithModel:model];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
//cell的高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 190;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
