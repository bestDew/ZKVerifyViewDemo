//
//  UIBezierPath+ZKPathMaker.m
//  ZKVerifyViewDemo
//
//  Created by bestdew on 2018/11/25.
//  Copyright © 2018 bestdew. All rights reserved.
//
//                      d*##$.
// zP"""""$e.           $"    $o
//4$       '$          $"      $
//'$        '$        J$       $F
// 'b        $k       $>       $
//  $k        $r     J$       d$
//  '$         $     $"       $~
//   '$        "$   '$E       $
//    $         $L   $"      $F ...
//     $.       4B   $      $$$*"""*b
//     '$        $.  $$     $$      $F
//      "$       R$  $F     $"      $
//       $k      ?$ u*     dF      .$
//       ^$.      $$"     z$      u$$$$e
//        #$b             $E.dW@e$"    ?$
//         #$           .o$$# d$$$$c    ?F
//          $      .d$$#" . zo$>   #$r .uF
//          $L .u$*"      $&$$$k   .$$d$$F
//           $$"            ""^"$$$P"$P9$
//          JP              .o$$$$u:$P $$
//          $          ..ue$"      ""  $"
//         d$          $F              $
//         $$     ....udE             4B
//          #$    """"` $r            @$
//           ^$L        '$            $F
//             RN        4N           $
//              *$b                  d$
//               $$k                 $F
//               $$b                $F
//                 $""               $F
//                 '$                $
//                  $L               $
//                  '$               $
//                   $               $

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
