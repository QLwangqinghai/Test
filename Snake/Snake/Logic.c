//
//  Logic.c
//  Snake
//
//  Created by vector on 2020/5/30.
//  Copyright © 2020 haoqi. All rights reserved.
//

#include "Logic.h"
#include <stdlib.h>
#include <string.h>


int32_t SnakeRandom() {
    return arc4random() % (1024 * 1024);
}


Logic_t * _Nonnull SnakeCreate(int32_t width, int32_t height) {
    Logic_t * result = malloc(sizeof(Logic_t));
    
    Logic_t logic = {};
    logic.width = 40;
    logic.height = 40;
    size_t size = 40 * 40 * sizeof(int32_t);
    logic.world = malloc(size);
    bzero(logic.world, size);
    logic.body = malloc(size);
    bzero(logic.body, size);

    memcpy(result, &logic, sizeof(Logic_t));
    
    //......
    return result;
}

void SnakeStart(Logic_t * _Nonnull logic) {
    
    logic->length = 1;
    logic->body[0] = 40 * 20 + 20;
    logic->world[logic->body[0]] = RectStateBody;

}


void SnakeSetDirection(Logic_t * _Nonnull logic, int32_t dir) {
    logic->direction = dir;
}

void SnakeSetLength(Logic_t * _Nonnull logic, int32_t newLength) {
    logic->length = newLength;
}


//返回1时表示食物被吃掉了, 返回0继续， 返回-1表示蛇死了
int SnakeGo(Logic_t * _Nonnull logic, int32_t dir) {
    int32_t width = logic->width;
    int32_t height = logic->height;
    int32_t * _Nonnull world = logic->world;//RectState
    int32_t * _Nonnull body = logic->body;//world 中的index
    int32_t direction = logic->direction;
    int32_t length = logic->length;//蛇身长

    
    
    
    
    
    
    
//    SnakeSetDirection(logic, dir);
//
//    //4 -> 5
//    SnakeSetLength(logic, 5);
    
    
    
    
    return 0;
}

