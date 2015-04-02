//
//  ViewController.m
//  CryptPBKDF2
//
//  Created by Oliver and Vienne Ng on 2/4/15.
//  Copyright (c) 2015 ONG. All rights reserved.
//

#import "ViewController.h"
#import "RNEncryptor.h"
#import "RNDecryptor.h"

@interface ViewController ()

@end


@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)encryptButton:(id)sender {
  // first, lets create a file to store the encrypted data
  NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/encryptedMsg.txt"];

  // get secret message from the two fields and the secret
  NSString *message = self.messageTextField.text;
  NSString *secret = self.secretTextField.text;
  
  // convert string to NSData object using NSArchiver
  NSData *messageData = [NSKeyedArchiver archivedDataWithRootObject:message];
  
  // begin the encryption process using RNENCryptor, capture error status
  NSError *error = nil;
  NSData *encrypted = [RNEncryptor encryptData:messageData
                                  withSettings:kRNCryptorAES256Settings
                                      password:secret error:&error ];

  // Any error?
  if (!error){
    self.secretWindow.text = @"Press the decrypt button now, to get your data from the file.";
    
    // Good to go! write the encrypted data to file
    [encrypted writeToFile:filePath
                   options:NSDataWritingFileProtectionComplete
                     error:&error];
  }
  else {
    NSLog(@"Problem with encryption");
  }
  

}


- (IBAction)decryptButton:(id)sender{
  // first, lets get the stored encrypted data
  NSString *filePath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/encryptedMsg.txt"];
  NSData *encryptedData = [NSData dataWithContentsOfFile:filePath];

  if (encryptedData != nil){
    // get secret key from the user
    NSString *secret = self.secretTextField.text;
    
    // try to decrypt using secret key
    NSError *error = nil;
    NSData *decrypted = [RNDecryptor decryptData:encryptedData withPassword:secret error:&error];
    
    // any errors?
    if (!error){
      // display message from decrypted file in the textview
      self.secretWindow.text = (NSString *)[NSKeyedUnarchiver unarchiveObjectWithData:decrypted];
      
      // Good to go! delete the decrypted file
      NSFileManager *fileManager = [NSFileManager defaultManager];
      [fileManager removeItemAtPath:filePath error:&error];
      
      if (!error)
        [self createAlert:@"Success! Deleted the file."];
    }
    else {
      // problem decrypting, maybe key is wrong
      [self createAlert:@"Problem with decryption.  Did you enter the right key?"];
    }
  }
  else{
    // no such file
    [self createAlert:@"file no existz?!"];
  }
}


- (void)createAlert:(NSString *)messageStr{
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Crazy person"
                                                  message:messageStr
                                                 delegate:self
                                        cancelButtonTitle:@"Oh, Right"
                                        otherButtonTitles:nil];
  [alert show];
}





- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
