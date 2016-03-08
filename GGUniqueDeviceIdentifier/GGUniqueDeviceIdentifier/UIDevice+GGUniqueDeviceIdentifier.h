//
//  UIDevice+GGUniqueDeviceIdentifier.h
//  GGUniqueDeviceIdentifier
//
//  Created by Gil on 16/3/8.
//  Copyright © 2016年 GilGuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (GGUniqueDeviceIdentifier)

/**
 *  获取设备的唯一编码
 *
 *  @return 设备唯一编码
 */
+ (NSString *)uniqueDeviceIdentifier;

@end
