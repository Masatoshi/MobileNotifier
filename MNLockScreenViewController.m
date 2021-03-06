/*
Copyright (c) 2010-2011, Peter Hajas
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright
      notice, this list of conditions and the following disclaimer in the
      documentation and/or other materials provided with the distribution.
    * Neither the name of the Peter Hajas nor the
      names of its contributors may be used to endorse or promote products
      derived from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL PETER HAJAS BE LIABLE FOR ANY
DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
*/

#import "MNLockScreenViewController.h"

@implementation MNLockScreenViewController

@synthesize delegate = _delegate;

-(id)initWithDelegate:(id)__delegate;
{
    self = [super init];
    if(self)
    {
        lockWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0,115,320,60)];
        lockWindow.userInteractionEnabled = NO;
        lockWindow.windowLevel = UIWindowLevelAlert+102.0f;
        lockWindow.hidden = YES;
        
    	logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 32, 32)];
        logoImageView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/MobileNotifier/lockscreen-logo.png"];

        backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,320,60)];
        backgroundImageView.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/MobileNotifier/lockscreenbg.png"];
        backgroundImageView.opaque = NO;
        
        numberOfPendingAlertsLabel = [[UILabel alloc] initWithFrame:CGRectMake(265,18,35,22)];
        numberOfPendingAlertsLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        numberOfPendingAlertsLabel.textAlignment = UITextAlignmentCenter;
    	numberOfPendingAlertsLabel.textColor = [UIColor blackColor];
        numberOfPendingAlertsLabel.backgroundColor = [UIColor clearColor];
        numberOfPendingAlertsLabel.opaque = NO;
        
        numberOfPendingAlertsBackground = [[UIImageView alloc] initWithFrame:CGRectMake(270,20,27,20)];
        numberOfPendingAlertsBackground.image = [UIImage imageWithContentsOfFile:@"/Library/Application Support/MobileNotifier/lockscreen-count-bg.png"];
        numberOfPendingAlertsBackground.opaque = NO;
        
        mobileNotifierTextLabel = [[UILabel alloc] initWithFrame:CGRectMake(60,20,180,22)];
        mobileNotifierTextLabel.text = @"MobileNotifier";
        mobileNotifierTextLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:18];
        mobileNotifierTextLabel.textAlignment = UITextAlignmentLeft;
    	mobileNotifierTextLabel.textColor = [UIColor whiteColor];
    	mobileNotifierTextLabel.shadowColor = [UIColor blackColor];
    	mobileNotifierTextLabel.shadowOffset = CGSizeMake(0,-1);
        mobileNotifierTextLabel.backgroundColor = [UIColor clearColor];
        
        [lockWindow addSubview:backgroundImageView];
        [lockWindow addSubview:logoImageView];
        [lockWindow addSubview:numberOfPendingAlertsBackground];
        [lockWindow addSubview:numberOfPendingAlertsLabel];
        [lockWindow addSubview:mobileNotifierTextLabel];
        
        _delegate = __delegate;
        
        [self refresh];
    }
    return self;
}

-(void)refresh
{
    NSNumber *pendingCount = [NSNumber numberWithInt:[[_delegate getPendingAlerts] count]];
    //Use the NSNumber's string value
    numberOfPendingAlertsLabel.text = [pendingCount stringValue];
}

-(void)hide
{
    lockWindow.hidden = YES;
}

-(void)show
{
    lockWindow.hidden = NO;
    [self refresh];
}

-(bool)isShowing
{
    return !lockWindow.hidden;
}

@end