# ZKVerifyView

一款可高度自定制的拼图验证码视图封装。

## Demo效果图

![image](https://github.com/bestDew/ZKVerifyViewDemo/blob/master/ZKVerifyViewDemo/Untitled.gif)

注意：效果图中的弹窗为外部单独实现，本库仅仅提供中间拼图验证码视图的封装，在实际应用中需要你自己根据项目UI效果图进行二次封装。

## API展示

```objc

typedef NS_ENUM(NSInteger, ZKPuzzleVerifyStyle) {
    ZKPuzzleVerifyStyleClassic,   // 默认
    ZKPuzzleVerifyStyleSquare,    // 矩形
    ZKPuzzleVerifyStyleCircle,    // 圆形
    ZKPuzzleVerifyStyleCustom     // 自定义
};

@interface ZKPuzzleVerifyView : UIView

/** 验证码图片 */
@property (nonatomic, strong) UIImage *image;
/** 布局区域距父视图的内边距（默认 UIEdgeInsetsZero） */
@property (nonatomic, assign) UIEdgeInsets containerInsert;
/** 验证容差值，意思是滑块与空白部分重合偏差在该值范围内即视为验证成功（默认 5.f）*/
@property (nonatomic, assign) CGFloat tolerance;
/** 横向平移百分比值（0.f ~ 1.f） */
@property (nonatomic, assign) CGFloat translation;

/** 是否通过验证 */
@property (nonatomic, readonly, assign) BOOL isVerified;
/** 是否可用 */
@property (nonatomic, assign, getter=isEnable) BOOL enable;

/** 滑块风格（具体指滑块的形状） */
@property (nonatomic, assign) ZKPuzzleVerifyStyle style;
/** 滑块的大小（默认 40.f）*/
@property (nonatomic, assign) CGSize puzzleSize;
/** 自定义滑块形状（仅当 style == ZKVerifyPuzzleStyleCustom 时有效）*/
@property (nonatomic, strong) UIBezierPath *puzzlePath;

/** 指定初始化 */
- (instancetype)initWithFrame:(CGRect)frame style:(ZKPuzzleVerifyStyle)style NS_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/** 刷新验证码 */
- (void)refresh;
/**
 检查验证结果
 
 @param result 结果回调
 @param animated 是否显示动画
 */
- (void)checkVerificationResults:(nullable void (^)(BOOL isVerified))result animated:(BOOL)animated;

@end

```

## 感谢

如果对你有帮助, 赏颗星吧😘。
