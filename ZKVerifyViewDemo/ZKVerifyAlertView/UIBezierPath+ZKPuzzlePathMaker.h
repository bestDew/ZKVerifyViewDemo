//
//  UIBezierPath+ZKPathMaker.h
//  ZKVerifyViewDemo
//
//  Created by bestdew on 2018/11/25.
//  Copyright © 2018 bestdew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZKPuzzlePathMaker.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIBezierPath (ZKPuzzlePathMaker)

+ (instancetype)bezierPathWithPathMaker:(void(^)(ZKPuzzlePathMaker *maker))maker;

@end

NS_ASSUME_NONNULL_END
