//
//  ViewController.h
//  CryptPBKDF2
//
//  Created by Oliver Ng on 30/5/15.
//  Copyright (c) 2015 Security Compass. All rights reserved.
//  http://www.securitycompass.com
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UITextField *secretTextField;
@property (weak, nonatomic) IBOutlet UITextView *secretWindow;


- (IBAction)encryptButton:(id)sender;
- (IBAction)decryptButton:(id)sender;


@end

