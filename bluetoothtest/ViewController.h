//
//  ViewController.h
//  bluetoothtest
//
//  Created by 小林 淳 on 12/09/03.
//  Copyright (c) 2012年 小林 淳. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *send_data;
- (IBAction)connect:(id)sender;
- (IBAction)send:(id)sender;

@end
