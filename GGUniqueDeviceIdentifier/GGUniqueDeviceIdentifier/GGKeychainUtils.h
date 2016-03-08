//
//  GGKeyChainUtils.h
//  GGUniqueDeviceIdentifier
//
//  Created by Gil on 16/3/8.
//  Copyright © 2016年 GilGuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GGKeychainUtils : NSObject

/**
 *  从钥匙串中获取字符串
 *
 *  @param account kSecAttrAccount
 *  @param error   NSError
 *
 *  @return NSString
 */
+ (NSString *)getItemWithAccount:(NSString *)account error:(NSError **)error;

/**
 *  将字符串存入钥匙串中
 *
 *  @param item           需要存入钥匙串的字符串
 *  @param account        kSecAttrAccount
 *  @param updateExisting 是否强制更新
 *  @param error          NSError
 *
 *  @return true or false
 */
+ (BOOL)storeItem:(NSString *)item withAccount:(NSString *)account updateExisting:(BOOL)updateExisting error:(NSError **)error;

@end
