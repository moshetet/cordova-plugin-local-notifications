/*
 * Copyright (c) 2013-2015 by appPlant UG. All rights reserved.
 *
 * @APPPLANT_LICENSE_HEADER_START@
 *
 * This file contains Original Code and/or Modifications of Original Code
 * as defined in and that are subject to the Apache License
 * Version 2.0 (the 'License'). You may not use this file except in
 * compliance with the License. Please obtain a copy of the License at
 * http://opensource.org/licenses/Apache-2.0/ and read it before using this
 * file.
 *
 * The Original Code and all software distributed under the License are
 * distributed on an 'AS IS' basis, WITHOUT WARRANTY OF ANY KIND, EITHER
 * EXPRESS OR IMPLIED, AND APPLE HEREBY DISCLAIMS ALL SUCH WARRANTIES,
 * INCLUDING WITHOUT LIMITATION, ANY WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE, QUIET ENJOYMENT OR NON-INFRINGEMENT.
 * Please see the License for the specific language governing rights and
 * limitations under the License.
 *
 * @APPPLANT_LICENSE_HEADER_END@
 */

#import "UILocalNotification+APPUserNotificationActions.h"

@implementation UILocalNotification (APPUserNotificationActions)

- (void) setActions:(NSDictionary*)actions
{
    UIMutableUserNotificationAction *action = [[UIMutableUserNotificationAction alloc] init];
    action.identifier = actions[@"id"] ? actions[@"id"] : @"NOTIFICATION_ACTION_IDENTIFIER";
    action.title = actions[@"title"];

    action.activationMode = UIUserNotificationActivationModeBackground;

    // If YES the action is red
    action.destructive = 0; // actions[@"destructive"];

    // If YES requires passcode, but does not unlock the device
    action.authenticationRequired = 0; // actions[@"authenticationRequired"];

    [self createCategoryWithActions:[NSArray arrayWithObjects:action, nil]];
}

- (void) createCategoryWithActions:(NSArray*)actions
{
    UIMutableUserNotificationCategory *category = [[UIMutableUserNotificationCategory alloc] init];
    category.identifier = @"USER_NOTIFICATION_CATEGORY";

    [category setActions:actions forContext:UIUserNotificationActionContextDefault];

    UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound);

    NSSet *categories = [NSSet setWithObjects:category, nil];
    UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:categories];

    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
}

@end
