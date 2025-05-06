#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

// alittle cheese
#define BITS 12
#define LINES 1000

//test
// #define BITS 5
int part_1(FILE *file);
int part_2(FILE *file);

int main(){
    FILE *file = fopen("input.txt", "r");
    if(file == NULL) { puts("failed to open file"); return -1; }

    printf("Part 1: %d\n", part_1(file));
    file = fopen("test.txt", "r");
    printf("Part 2: %d\n", part_2(file));


    fclose(file);
    return 0;
}

int part_1(FILE *file){
    if(file == NULL) { puts("failed to open file"); return -1;}

    char buff[256];
    char* line;


    int freq[BITS] = {0};
    while(1){
        line = fgets(buff, sizeof(buff), file);
        if(line == NULL) break;

        char c;
        for(int i = 0; i < strlen(line)-1; i++){
            c = line[i];
            if(c == '0'){
                freq[i] -= 1;
            } else if(c == '1'){
                freq[i] += 1;
            }
        }
    }
    // neg number means, 0 was more common
    // pos number means, 1 was more common
    int gamma = 0;
    int epsilon = 0;
    for(int i = 1; i <= BITS; i++){
        if(freq[BITS-i] > 0){
            gamma += (int) pow(2, i-1);
        } else {
            epsilon += (int) pow(2, i-1);
        }
    }
    // it would be so cool to use bitwise operations
    // but its not as simple as doing ~bits, because there is not explicit 12bit type
    // epsilon = ~gamma;
    return gamma * epsilon;
}

int part_2(FILE *file){
    if(file == NULL) { puts("failed to open file"); return -1;}

    char buff[256];
    char* line;

    // you have to completly rewrite everything
    return 0;
}
