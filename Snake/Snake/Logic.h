//
//  Logic.h
//  Snake
//
//  Created by vector on 2020/5/30.
//  Copyright © 2020 haoqi. All rights reserved.
//

#ifndef Logic_h
#define Logic_h

#include <stdio.h>

enum Direction {
    DirectionUp = 0,
    DirectionRight = 1,
    DirectionDown = 2,
    DirectionLeft = 3,
};

enum RectState {
    RectStateNone = 0,
    RectStateFood = 1,
    RectStateBody = 2,
};

typedef struct Logic {
    int32_t width;
    int32_t height;
    int32_t * _Nonnull world;//RectState
    int32_t * _Nonnull body;//world 中的index
    enum Direction direction;
    int32_t length;//蛇身长
} Logic_t;


Logic_t * _Nonnull SnakeCreate(int32_t width, int32_t height);


void SnakeStart(Logic_t * _Nonnull logic);


int SnakeGo(Logic_t * _Nonnull logic, int32_t dir);


#endif /* Logic_h */
