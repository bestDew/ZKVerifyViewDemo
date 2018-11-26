//
//  UIBezierPath+ZKPathMaker.m
//  ZKVerifyViewDemo
//
//  Created by bestdew on 2018/11/25.
//  Copyright © 2018 bestdew. All rights reserved.
//

#import "UIBezierPath+ZKPuzzlePathMaker.h"

@implementation UIBezierPath (ZKPuzzlePathMaker)

+ (instancetype)bezierPathWithPathMaker:(void(^)(ZKPuzzlePathMaker *maker))maker
{
    UIBezierPath *path = [UIBezierPath bezierPath];
    if (maker) {
        ZKPuzzlePathMaker *pathMaker = [[ZKPuzzlePathMaker alloc] initWithBezierPath:path];
        maker(pathMaker);
    }
    return path;
}

@end
