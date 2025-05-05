#include <stdio.h>
#include <stdlib.h>

int part_1(FILE *file);
int part_2(FILE *file);

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
    if(file == NULL) { puts("failed to open file"); return -1; }

    // store the line
    char buff[256];
    char* line;
    int prev;
    int curr;
    int increments = 0;
    while(1){
        line = fgets(buff, sizeof(buff), file);
        if(line == NULL) break;

        curr = atoi(line);

        if(!prev){
            prev = curr;
            continue;
        }
        if(prev < curr) increments += 1;

        prev = curr;
    }

    return increments;
}

int part_2(FILE* file){
    if(file == NULL) { puts("failed to open file"); return -1; }

    char buff[256];
    char* line;


    // these are horibble variable names
    // last_2, last_1, curr, ..........n
    // turns out you cant even check if a int is uninitialized WOW
    // is the start variable necessary?
    int last_1 = -1;
    int last_2 = -1;
    int curr;

    int prevsum = -1;
    int currsum;
    int increments = 0;

    while(1){
        line = fgets(buff, sizeof(buff), file);
        if(line == NULL) break;

        curr = atoi(line);

        if(last_2 == -1 && last_1 == -1){
            last_1 = curr;
            continue;
        }
        if(last_2 == -1){
            last_2 = last_1;
            // i forgot this
            last_1 = curr;
            continue;
        }

        currsum = curr + last_1 + last_2;

        if(prevsum == -1){
            prevsum = currsum;
            last_2 = last_1;
            last_1 = curr;
            continue;
        }



        if(prevsum < currsum) increments += 1;
        prevsum = currsum;
        last_2 = last_1;
        last_1 = curr;
    }

    return increments;
}
