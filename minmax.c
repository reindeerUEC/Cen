#include <stdio.h>
#include <stdlib.h>

int main(void) {
  int m;
  int i = -1;
  int A[10009];
  while (1) {
    scanf("%d", &m);
    if (m == 0) {
      break;
    } else {
      A[++i] = m;
    }
  }
  int N = i;
  int max = A[N];
  int min = A[N];

  for (int j = N; j >= 0; j--) {
    if (A[j] < min) {
      min = A[j];
    }
    if (A[j] > max) {
      max = A[j];
    }
  }

  for (int j = N; j >= 0; j--) {
    printf("%d", A[j]);
    if (A[j] == max) printf(" (max) ");
    if (A[j] == min) printf(" (min) ");
    printf("\n");
  }
}
