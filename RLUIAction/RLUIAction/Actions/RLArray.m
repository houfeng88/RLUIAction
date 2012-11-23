//
//  RLArray.m
//  rlterm3
//
//  Created by houfeng on 12-11-22.
//  Copyright (c) 2012年 houfeng. All rights reserved.
//

#import "RLArray.h"
rlArray* rlArrayNew(NSUInteger capacity)
{
    if(capacity==0)
        capacity=1;
    rlArray *arr =(rlArray*)malloc(sizeof(rlArray));
    arr->num=0;
    arr->arr=(RLARRAY_ID *)calloc(capacity, sizeof(id));
    arr->max=capacity;
    return arr;
}

void rlArrayFree(rlArray *arr)
{
    if(arr == nil)return;
    
}
void rlArrayDoubleCapacity(rlArray *arr)
{
    
}
void rlArrayEnsureExtraCapacity(rlArray *arr,NSUInteger extra)
{
    
}
void ccArrayShrink(rlArray *arr)
{
    
}




@implementation RLArray

@end
