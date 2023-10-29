// compile with tcc: tcc consile-size.c

#include <windows.h>
#include <stdio.h>

int main(int argc, char *argv[]) {
    CONSOLE_SCREEN_BUFFER_INFO csbi;
    int columns, lines;

    // Use STD_ERROR_HANDLE - STD_OUTPUT_HANDLE changed with redirection.
    GetConsoleScreenBufferInfo(GetStdHandle(STD_ERROR_HANDLE), &csbi);
    columns = csbi.srWindow.Right - csbi.srWindow.Left + 1;
    lines = csbi.srWindow.Bottom - csbi.srWindow.Top + 1;

    printf("%d,%d", columns, lines);
    return 0;
}
