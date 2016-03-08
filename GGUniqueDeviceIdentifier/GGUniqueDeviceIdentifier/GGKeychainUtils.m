//
//  GGKeyChainUtils.m
//  GGUniqueDeviceIdentifier
//
//  Created by Gil on 16/3/8.
//  Copyright © 2016年 GilGuan. All rights reserved.
//

#import "GGKeychainUtils.h"

#define GGKetchainErrorCodeIncorrect	-1999
#define GGKetchainErrorCodeNomal		-2000
static NSString *GGKeychainUtilsErrorDomain = @"GGKeychainUtilsErrorDomain";

@implementation GGKeychainUtils

+ (NSMutableDictionary *)keychainQuery:(NSString *)account {
	/**
	 *  设置 kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly，是keychain不被iCloud同步
	 *  即使同一个Apple id，不同的设备也有不同的值
	 */
	return [NSMutableDictionary dictionaryWithObjectsAndKeys:
		   (__bridge id)(kSecClassGenericPassword), kSecClass,
		   [NSBundle mainBundle].bundleIdentifier, kSecAttrService,
            account, kSecAttrAccount,
		   kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly, kSecAttrAccessible, nil];
}

+ (NSString *)getItemWithAccount:(NSString *)account error:(NSError **)error {
	if (!account) {
		if (error != nil) {
			*error = [NSError errorWithDomain:GGKeychainUtilsErrorDomain code:GGKetchainErrorCodeNomal userInfo:nil];
		}
		return nil;
	}

	if (error != nil) {
		*error = nil;
	}

	NSMutableDictionary *query = [GGKeychainUtils keychainQuery:account];
	[query setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
	[query setObject:(__bridge id)(kSecMatchLimitOne) forKey:(__bridge id < NSCopying >)(kSecMatchLimit)];

	CFTypeRef resData = NULL;
	OSStatus status = SecItemCopyMatching((__bridge_retained CFDictionaryRef)query, (CFTypeRef *)&resData);
	NSData *resultData = (__bridge_transfer NSData *)resData;

	if (status != noErr) {
		if (error != nil && status != errSecItemNotFound) {
			*error = [NSError errorWithDomain:GGKeychainUtilsErrorDomain code:status userInfo:nil];
		}
		return nil;
	}

	NSString *result = nil;
	if (resultData) {
		result = [[NSString alloc] initWithData:resultData encoding:NSUTF8StringEncoding];
	}
	else {
		if (error != nil) {
			*error = [NSError errorWithDomain:GGKeychainUtilsErrorDomain code:GGKetchainErrorCodeIncorrect userInfo:nil];
		}
	}
	return result;
}

+ (BOOL)storeItem:(NSString *)item withAccount:(NSString *)account updateExisting:(BOOL)updateExisting error:(NSError **)error {
	if (!account) {
		if (error != nil) {
			*error = [NSError errorWithDomain:GGKeychainUtilsErrorDomain code:GGKetchainErrorCodeNomal userInfo:nil];
		}
		return NO;
	}

	NSError *getError = nil;
	NSString *existingResult = [GGKeychainUtils getItemWithAccount:account error:&getError];

	if ([getError code] == GGKetchainErrorCodeIncorrect) {
		getError = nil;

		[self deleteItemForAccount:account error:&getError];

		if ([getError code] != noErr) {
			if (error != nil) {
				*error = getError;
			}
			return NO;
		}
	}
	else if ([getError code] != noErr) {
		if (error != nil) {
			*error = getError;
		}
		return NO;
	}

	if (error != nil) {
		*error = nil;
	}

	OSStatus status = noErr;

	if (existingResult) {
		if (![existingResult isEqualToString:item] && updateExisting) {
			NSDictionary *query = [GGKeychainUtils keychainQuery:account];
			status = SecItemUpdate((__bridge_retained CFDictionaryRef)query, (__bridge_retained CFDictionaryRef)[NSDictionary dictionaryWithObject:[item dataUsingEncoding:NSUTF8StringEncoding] forKey:(__bridge_transfer NSString *)kSecValueData]);
		}
	}
	else {
		NSMutableDictionary *query = [GGKeychainUtils keychainQuery:account];
		[query setObject:[item dataUsingEncoding:NSUTF8StringEncoding] forKey:(__bridge_transfer NSString *)kSecValueData];

		status = SecItemAdd((__bridge_retained CFDictionaryRef)query, NULL);
	}

	if (error != nil && status != noErr) {
		*error = [NSError errorWithDomain:GGKeychainUtilsErrorDomain code:status userInfo:nil];
		return NO;
	}
	return YES;
}

+ (BOOL)deleteItemForAccount:(NSString *)account error:(NSError **)error {
	if (!account) {
		if (error != nil) {
			*error = [NSError errorWithDomain:GGKeychainUtilsErrorDomain code:GGKetchainErrorCodeNomal userInfo:nil];
		}
		return NO;
	}

	if (error != nil) {
		*error = nil;
	}

	NSDictionary *query = [GGKeychainUtils keychainQuery:account];
	OSStatus status = SecItemDelete((__bridge_retained CFDictionaryRef)query);

	if (error != nil && status != noErr) {
		*error = [NSError errorWithDomain:GGKeychainUtilsErrorDomain code:status userInfo:nil];
		return NO;
	}
	return YES;
}

@end
