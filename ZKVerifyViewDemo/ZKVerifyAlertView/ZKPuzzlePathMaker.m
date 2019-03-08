//
//  ZKPuzzlePathMaker.m
//  ZKVerifyViewDemo
//
//  Created by bestdew on 2018/11/25.
//  Copyright © 2018 bestdew. All rights reserved.
//

#import "ZKPuzzlePathMaker.h"

@implementation ZKPuzzlePathMaker

#pragma mark -- Init
- (instancetype)init
{
    return [self initWithBezierPath:nil];
}

+ (instancetype)makerWithBezierPath:(UIBezierPath *)path
{
    return [[self alloc] initWithBezierPath:path];
}

- (instancetype)initWithBezierPath:(UIBezierPath *)path
{
    if (self = [super init]) {
        
        self.path = path;
    }
    return self;
}

#pragma mark -- Getter
- (ZKPuzzlePathMaker *(^)(CGFloat, CGFloat))moveTo
{
    return ^(CGFloat x, CGFloat y){
        [self.path moveToPoint:CGPointMake(x, y)];
        return self;
    };
}

- (ZKPuzzlePathMaker *(^)(CGFloat, CGFloat))addLineTo
{
    return ^(CGFloat x, CGFloat y){
        [self.path addLineToPoint:CGPointMake(x, y)];
        return self;
    };
}

- (ZKPuzzlePathMaker *(^)(CGFloat, CGFloat, CGFloat, CGFloat))addQuadCurveTo
{
    return ^(CGFloat endX, CGFloat endY, CGFloat controlX, CGFloat controlY){
        [self.path addQuadCurveToPoint:CGPointMake(endX, endY) controlPoint:CGPointMake(controlX, controlY)];
        return self;
    };
}

- (ZKPuzzlePathMaker *(^)(CGFloat, CGFloat, CGFloat, CGFloat, CGFloat, CGFloat))addCurveTo
{
    return ^(CGFloat endX, CGFloat endY, CGFloat controlX1, CGFloat controlY1, CGFloat controlX2, CGFloat controlY2){
        [self.path addCurveToPoint:CGPointMake(endX, endY) controlPoint1:CGPointMake(controlX1, controlY1) controlPoint2:CGPointMake(controlX2, controlY2)];
        return self;
    };
}

- (ZKPuzzlePathMaker *(^)(CGFloat, CGFloat, CGFloat, CGFloat, CGFloat, BOOL))addArcWithCenter
{
    return ^(CGFloat centerX, CGFloat centerY, CGFloat radius, CGFloat startAngle, CGFloat endAngle, BOOL clockwise){
        [self.path addArcWithCenter:CGPointMake(centerX, centerY) radius:radius startAngle:startAngle endAngle:endAngle clockwise:clockwise];
        return self;
    };
}

- (ZKPuzzlePathMaker *(^)(CGFloat, CGFloat, CGFloat, CGFloat, CGFloat, BOOL, BOOL))addArcWithPoint
{
    return ^(CGFloat startX, CGFloat startY, CGFloat endX, CGFloat endY, CGFloat radius, BOOL clockwise, BOOL moreThanHalf){
        [self addArcPathWithStartPoint:CGPointMake(startX, startY) endPoint:CGPointMake(endX, endY) radius:radius clockwise:clockwise moreThanHalf:moreThanHalf];
        return self;
    };
}


- (ZKPuzzlePathMaker *(^)(void))closePath
{
    return ^(void){
        [self.path closePath];
        return self;
    };
}

- (ZKPuzzlePathMaker *(^)(CGFloat, CGFloat, CGFloat, CGFloat, CGFloat))addSin
{
    return ^(CGFloat A, CGFloat Omega, CGFloat Phi, CGFloat K, CGFloat deltaX){
        [self addSinPathWithA:A Omega:Omega Phi:Phi K:K deltaX:deltaX];
        return self;
    };
}

- (ZKPuzzlePathMaker *(^)(ZKPathMirrorAxis, CGFloat, CGFloat, CGFloat, CGFloat))mirror
{
    return ^(ZKPathMirrorAxis axis, CGFloat x, CGFloat y, CGFloat width, CGFloat height){
        [self mirrorPathWithAxis:axis rect:CGRectMake(x, y, width, height)];
        return self;
    };
}

- (ZKPuzzlePathMaker *(^)(CGFloat))scale
{
    return ^(CGFloat scale){
        [self scalePathWithScale:scale];
        return self;
    };
}

- (ZKPuzzlePathMaker *(^)(CGFloat))rotate
{
    return ^(CGFloat angle){
        [self rotatePathWithAngle:angle];
        return self;
    };
}

- (ZKPuzzlePathMaker *(^)(CGFloat, CGFloat))translate
{
    return ^(CGFloat offsetX, CGFloat offsetY){
        [self translatePathWithOffset:CGPointMake(offsetX, offsetY)];
        return self;
    };
}

- (ZKPuzzlePathMaker *(^)(void))moveToOrigin
{
    return ^(void){
        [self translatePathWithOffset:CGPointMake(-CGRectGetMinX(self.path.bounds), -CGRectGetMinY(self.path.bounds))];
        return self;
    };
}

#pragma mark -- Pravite Methods
- (void)addSinPathWithA:(CGFloat)A Omega:(CGFloat)Omega Phi:(CGFloat)Phi K:(CGFloat)K deltaX:(CGFloat)deltaX
{
    CGPoint originPoint = self.path.currentPoint;
    CGPoint currentPoint = self.path.currentPoint;
    CGFloat currentX = 0.f;
    CGFloat step = 0.05;
    
    while (currentX <= deltaX) {
        currentX += step;
        CGFloat sinValue1 = A * sinf(Omega * currentX + Phi) + K;
        CGFloat sinValue2 = A * sinf(Omega * (currentX - step) + Phi) + K;
        CGFloat deltaSinValue = sinValue1 = sinValue2;
        currentPoint = CGPointMake(currentPoint.x + step, currentPoint.y - deltaSinValue);
        [self.path addLineToPoint:currentPoint];
    }
    
    if (currentX != deltaX) {
        step = deltaX;
        CGFloat sinValue1 = A * sinf(Omega * deltaX + Phi) + K;
        CGFloat sinValue2 = A * sinf(Omega * (deltaX - step) + Phi) + K;
        CGFloat deltaSinValue = sinValue1 = sinValue2;
        [self.path addLineToPoint:CGPointMake(originPoint.x + step, originPoint.y - deltaSinValue)];
    }
}

- (void)mirrorPathWithAxis:(ZKPathMirrorAxis)axis rect:(CGRect)rect
{
    switch (axis) {
        case ZKPathMirrorAxisX:
            [self.path applyTransform:CGAffineTransformMakeScale(-1.f, 1.f)];
            [self translatePathWithOffset:CGPointMake(2 * rect.origin.x + rect.size.width, 0.f)];
            break;
        case ZKPathMirrorAxisY:
            [self.path applyTransform:CGAffineTransformMakeScale(1, -1)];
            [self translatePathWithOffset:CGPointMake(0.f, 2 * rect.origin.y + rect.size.height)];
            break;
    }
}

- (void)translatePathWithOffset:(CGPoint)offset
{
    if (CGPointEqualToPoint(offset, CGPointZero)) return;
    [self.path applyTransform:CGAffineTransformMakeTranslation(offset.x, offset.y)];
}

- (void)scalePathWithScale:(CGFloat)scale
{
    if (scale == 1) return;
    
    CGFloat marginX = CGRectGetWidth(self.path.bounds) * (1.f - scale) * 0.5;
    CGFloat marginY = CGRectGetHeight(self.path.bounds) * (1.f - scale) * 0.5;
    [self.path applyTransform:CGAffineTransformMakeScale(scale, scale)];
    [self translatePathWithOffset:CGPointMake(marginX * 3, marginY * 3)];
}

- (void)rotatePathWithAngle:(CGFloat)angle
{
    angle = fmod(angle, M_PI * 2);
    if (angle == 0) return;
    
    CGFloat offsetX = CGRectGetMinX(self.path.bounds) + CGRectGetWidth(self.path.bounds) * 0.5;
    CGFloat offsetY = CGRectGetMinY(self.path.bounds) + CGRectGetHeight(self.path.bounds) * 0.5;
    [self translatePathWithOffset:CGPointMake(-offsetX, -offsetY)];
    [self.path applyTransform:CGAffineTransformMakeRotation(angle)];
    [self translatePathWithOffset:CGPointMake(offsetX, offsetY)];
}

- (void)addArcPathWithStartPoint:(CGPoint)startP endPoint:(CGPoint)endP radius:(CGFloat)radius clockwise:(BOOL)clockwise moreThanHalf:(BOOL)moreThanHalf
{
    CGPoint center = [self getCenterFromFirstPoint:startP secondPoint:endP radius:radius clockwise:clockwise moreThanhalf:moreThanHalf];
    CGFloat startA = [self getAngleFromFirstPoint:center secondP:startP];
    CGFloat endA = [self getAngleFromFirstPoint:center secondP:endP];
    [self.path addArcWithCenter:center radius:radius startAngle:startA endAngle:endA clockwise:clockwise];
}

// 根据两点、半径、顺逆时针获取圆心
- (CGPoint)getCenterFromFirstPoint:(CGPoint)firstP secondPoint:(CGPoint)secondP radius:(CGFloat)radius clockwise:(BOOL)clockwise moreThanhalf:(BOOL)moreThanHalf
{
    CGFloat centerX = 0.5 * secondP.x - 0.5 * firstP.x;
    CGFloat centerY = 0.5 * firstP.y - 0.5 * secondP.y;
    centerX = round6f(centerX);
    centerY = round6f(centerY);
    radius = round6f(radius);
    // 获取相似三角形相似比例
    CGFloat scale = sqrt((pow(radius, 2) - (pow(centerX, 2) + pow(centerY, 2))) / (pow(centerX, 2) + pow(centerY, 2)));
    scale = round6f(scale);
    if (clockwise != moreThanHalf) {
        return CGPointMake(centerX + centerY * scale + firstP.x, - centerY + centerX * scale + firstP.y);
    } else {
        return CGPointMake(centerX - centerY * scale + firstP.x, - centerY - centerX * scale + firstP.y);
    }
}

// 获取第二点相对第一点的角度
- (CGFloat)getAngleFromFirstPoint:(CGPoint)firstP secondP:(CGPoint)secondP
{
    CGFloat deltaX = secondP.x - firstP.x;
    CGFloat deltaY = secondP.y - firstP.y;
    deltaX = round6f(deltaX);
    deltaY = round6f(deltaY);
    if (deltaX > 0) {
        if (deltaY >= 0) return atanf(deltaY / deltaX);
        return M_PI * 2 + atanf(deltaY / deltaX);
    } else if (deltaX == 0) {
        if (deltaY >= 0) {
            return M_PI_2;
        } else {
            return M_PI_2 * 3;
        }
    }
    return atanf(deltaY / deltaX) + M_PI;
}

// 保留6位小数
CG_INLINE CGFloat round6f(CGFloat x) {
    return roundf(x * 1000000) / 1000000.0;
}

@end
