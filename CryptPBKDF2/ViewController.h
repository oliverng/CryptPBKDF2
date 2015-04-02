//
//  ViewController.h
//  CryptPBKDF2
//
//  Created by Oliver and Vienne Ng on 2/4/15.
//  Copyright (c) 2015 ONG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController


@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UITextField *secretTextField;
@property (weak, nonatomic) IBOutlet UITextView *secretWindow;


- (IBAction)encryptButton:(id)sender;
- (IBAction)decryptButton:(id)sender;


@end

