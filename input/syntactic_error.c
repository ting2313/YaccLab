/*
 * 2019 Spring Compiler Course Assignment 2
 */

float c = 1.5;

bool loop(int n, int m) {
    while (n > m) {
        n--;
    }
    n = m;
    return true;
}

int main() {
    // Declaration
    int x;
    int i;
    int a = 5;

    // syntactical error
    iff (a > 10) {
        x += a;
        print(x);
    } else {
        x = a % 10 + 10 * 7; /* Arithmetic */
        print(x);
    }
    print("Hello World");

    return 0;
}
