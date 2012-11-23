//
//  RLArray.h
//  rlterm3
//
//  Created by houfeng on 12-11-22.
//  Copyright (c) 2012年 houfeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#if defined(__has_feature) && __has_feature(objc_arc)
typedef __strong id CCARRAY_ID;
#else
typedef id RLARRAY_ID;
#endif

typedef struct rlArray
{
    NSUInteger num,max;
    RLARRAY_ID *arr;
}rlArray;
typedef int (*cc_comparator)(const void *, const void *);
rlArray* rlArrayNew(NSUInteger capacity);
void rlArrayFree(rlArray *arr);
void rlArrayDoubleCapacity(rlArray *arr);
void rlArrayEnsureExtraCapacity(rlArray *arr,NSUInteger extra);
void ccArrayShrink(rlArray *arr);




@interface RLArray : NSObject

@end
