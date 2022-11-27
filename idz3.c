#include <stdio.h>

double getX(double a);

double mabs(double x){
    return (x < 0)? -x : x;
}
int main() {
    double a;
    scanf("%lf", &a);
    int b = (a < 0)? 0 : 1;
    a = mabs(a);
    double x = getX(a);
    if(!b){
        x = -x;
    }
    printf("%lf", x);

    return 0;
}

double getX(double a) {
    double x0 = a/5;
    while(mabs(a - x0 * x0 * x0 * x0 * x0) >= 0.1){
        x0 = 0.2 * (4 * x0 + a / (x0 * x0 * x0 * x0));
    }
    return x0;
}
