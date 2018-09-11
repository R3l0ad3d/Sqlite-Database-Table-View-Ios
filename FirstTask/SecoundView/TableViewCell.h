//
//  TableViewCell.h
//  FirstTask
//
//  Created by Joy on 11/9/18.
//  Copyright © 2018 Joy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *myLabel;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;
- (IBAction)actionDelete:(id)sender;

@end
