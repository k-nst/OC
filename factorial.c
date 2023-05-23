#include <stdio.h>

int main() {
    int i, n, factorial;
    
    for (n = 1; n <= 6; n++) {
        factorial = 1;
        for (i = 1; i <= n; i++) {
            factorial = factorial * i;
        }
        printf("%d! = %d\n", n, factorial);
    }
    
    return 0;
}