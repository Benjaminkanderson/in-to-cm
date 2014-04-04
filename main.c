//
//  main.c
//  CS2810-project
//
//  Created by Charles Jones on 4/2/14.
//  Copyright (c) 2014 Charles Jones. All rights reserved.
//
#include <readline/readline.h>
#include <stdio.h>

unsigned a_to_f(const char *s)
{
    const char *digits = "0123456789";
    int result = 0;
    for (; *s; ++s)
    {
        int value;
        for(value = 0; digits[value]; ++value)
        {
            if(digits[value] == *s)
                break;
        }
        if(digits[value])
            result = 10 * result + value;
    }
    return result;
}

int main(int argc, const char * argv[])
{
    float num;
    const float conversion = 2.54;
    printf("Please enter a value in inches: ");
    const char* number = readline(NULL);
    num = a_to_f(number);
    num = num * conversion;
    num = num / 10;
    printf("The measurement in centimeters is %.2f\n",num);
}