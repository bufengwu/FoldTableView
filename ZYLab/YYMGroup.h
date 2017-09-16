//
//  YYMGroup.h
//  ZYLab
//
//  Created by DevKK on 2017/9/16.
//  Copyright © 2017年 DevKK. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YYMGroup : NSObject

@property (nonatomic, assign) BOOL isFolded;
@property (nonatomic, assign) NSInteger size;

@property (nonatomic, strong) NSArray *items;

@end
