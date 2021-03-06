//
//  UIDevice+GGUniqueDeviceIdentifier.m
//  GGUniqueDeviceIdentifier
//
//  Created by Gil on 16/3/8.
//  Copyright © 2016年 GilGuan. All rights reserved.
//

#import "UIDevice+GGUniqueDeviceIdentifier.h"
#import "GGKeychainUtils.h"

@implementation UIDevice (GGUniqueDeviceIdentifier)

static NSString *_uniqueDeviceIdentifier = nil;
+ (NSString *)uniqueDeviceIdentifier {
	if (!_uniqueDeviceIdentifier) {
		NSString *account = @"uniqueDeviceIdentifier";
		NSString *item = [GGKeychainUtils getItemWithAccount:account error:nil];
        //如果获取不到值，则生成一个uuid存入keychain中
		if (!item) {
			item = [self getUUID];
			NSAssert(item, @"uuid is nil.");
			[GGKeychainUtils storeItem:item withAccount:account updateExisting:YES error:nil];
		}
		_uniqueDeviceIdentifier = item;
	}

	return _uniqueDeviceIdentifier;
}

+ (NSString *)getUUID {
	NSString *uuidString = nil;

	CFUUIDRef uuid = CFUUIDCreate(NULL);

	uuidString = (NSString *)CFBridgingRelease(CFUUIDCreateString(NULL, uuid));
	CFRelease(uuid);

	return [uuidString lowercaseString];
}

@end
