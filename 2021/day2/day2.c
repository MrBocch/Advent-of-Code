#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int part_1(FILE *file);
int part_2(FILE *file);
int extract_num(char *line);

enum Axis check_axis(char *file);
enum Axis {
    UP,
    DOWN,
    FORWARD
};

struct Sub{
    int aim;
    unsigned int x;
    unsigned int y;
};

int main(){
    FILE *file = fopen("input.txt", "r");
    if(file == NULL) { puts("failed to open file"); return -1; }

    printf("Part 1: %d\n", part_1(file));
    file = fopen("input.txt", "r");
    printf("Part 2: %d\n", part_2(file));


    fclose(file);
    return 0;
}

int part_1(FILE *file){
    if(file == NULL) { puts("failed to open file"); return -1;}

    char buff[256];
    char* line;

    // up, down
    int y = 0;
    // forward, backwards
    int x = 0;

    while(1){
        line = fgets(buff, sizeof(buff), file);
        if(line == NULL) break;
        int magnitud = extract_num(line);
        enum Axis axis = check_axis(line);

        if(axis == UP) y -= magnitud;
        if(axis == DOWN) y += magnitud;
        if(axis == FORWARD) x += magnitud;
    }
    return x * y;
}

int part_2(FILE *file){
    if(file == NULL) { puts("failed to open file"); return -1;}

    char buff[256];
    char* line;

    struct Sub sub = {0};

    while(1){
        line = fgets(buff, sizeof(buff), file);
        if(line == NULL) break;
        int magnitud = extract_num(line);
        enum Axis command = check_axis(line);

        if(command == UP) sub.aim -= magnitud;
        if(command == DOWN) sub.aim += magnitud;
        // i did not encounter this (because i was using languages that use bigint types)
        // but i have read about it on forums
        // a integer overflow occurs here when using 32bit ints
        if(command == FORWARD) {
            sub.x += magnitud;
            sub.y += sub.aim * magnitud;
        }
    }

    return sub.x * sub.y;
}
enum Axis check_axis(char *line){
    // only checking first char to determine thing
    char c = line[0];
    // up
    if(c == 'u') return UP;
    if(c == 'd') return DOWN;
    if(c == 'f') return FORWARD;

}

int extract_num(char *line){
    int n;
    sscanf(line, "%*s %d", &n);
    return n;
}
