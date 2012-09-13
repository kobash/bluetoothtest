//
//  ViewController.m
//  bluetoothtest
//
//  Created by 小林 淳 on 12/09/03.
//  Copyright (c) 2012年 小林 淳. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    ConnectionManager *connectionManager;
}

@end

@implementation ViewController
@synthesize send_data;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

	connectionManager = [[ConnectionManager alloc] init];
    connectionManager.delegate = self;
    send_data.delegate = self; //←storyboradでも、紐付けできる。
}

- (void)viewDidUnload
{
    connectionManager.delegate = nil;
    connectionManager = nil;

    [self setSend_data:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)connectionManager:(ConnectionManager *)manager
           didReceiveData:(NSData *)data
                 fromPeer:(NSString *)peer
{
    NSString* msg = [[NSString alloc] initWithData:data
                                           encoding:NSUTF8StringEncoding];
    NSString* text = [self.send_data.text stringByAppendingFormat:@"%@\n", msg];
    self.send_data.text = text;
}


- (void)connectionManagerDidConnect:(ConnectionManager *)manager
{
}

- (void)connectionManagerDidDisconnect:(ConnectionManager *)manager
{
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)connect:(id)sender {
    [send_data resignFirstResponder];
    {
        if (connectionManager.isConnecting)
        {
            [connectionManager disconnect];
        }
        else
        {
            [connectionManager connect];
        }
    }
    
}

- (IBAction)send:(id)sender {
    [send_data resignFirstResponder];
    NSData *sendData = [self.send_data.text dataUsingEncoding:NSUTF8StringEncoding];

    [connectionManager sendDataToAllPeers:sendData];
}


- (IBAction)backgroundTap:(id)sender
{
    [send_data resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [send_data resignFirstResponder];
    return YES;
}


@end


