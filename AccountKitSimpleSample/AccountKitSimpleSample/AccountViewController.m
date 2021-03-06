// Copyright (c) 2014-present, Facebook, Inc. All rights reserved.
//
// You are hereby granted a non-exclusive, worldwide, royalty-free license to use,
// copy, modify, and distribute this software in source code or binary form for use
// in connection with the web services and APIs provided by Facebook.
//
// As with any software that integrates with the Facebook platform, your use of
// this software is subject to the Facebook Developer Principles and Policies
// [http://developers.facebook.com/policy/]. This copyright notice shall be
// included in all copies or substantial portions of the software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
// FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
// COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
// IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
// CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#import "AccountViewController.h"

#import <AccountKit/AccountKit.h>

@implementation AccountViewController
{
  AKFAccountKit *_accountKit;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];

  if (_accountKit == nil) {
    _accountKit = [[AKFAccountKit alloc] initWithResponseType:AKFResponseTypeAccessToken];
    [_accountKit requestAccount:^(id<AKFAccount> account, NSError *error) {
      if (error != nil) {
        self.accountIDLabel.text = @"N/A";
        self.titleLabel.text = @"Error";
        self.valueLabel.text = [error description];
      } else {
        self.accountIDLabel.text = account.accountID;
        if ([account.emailAddress length] > 0) {
          self.titleLabel.text = @"Email Address";
          self.valueLabel.text = account.emailAddress;
        } else if ([account phoneNumber] != nil) {
          self.titleLabel.text = @"Phone Number";
          self.valueLabel.text = [account.phoneNumber stringRepresentation];
        }
      }
    }];
  }
}

- (void)logout:(id)sender
{
  [_accountKit logOut];
  [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
