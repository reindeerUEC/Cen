#include <stdio.h>
#include <stdlib.h>

int main(void) {
  int m;
  int i = -1;
  int A[10009];
scan_loop:
    scanf("%d", &m);
    if (m == 0) {
      j scan_loop_exit:
    } 
    A[++i] = m;
    j scan_loop;
scan_loop_exit:
  int N = i;
  int max = A[N];
  int min = A[N];

  int $sp=A
minmax_loop:
    if $t1==0 j minmax_loop_exit
    lw $t1, 0($sp)
    add $sp, $sp, -4 # スタックに1ワードの領域を確
    if ($t1 < min) {
      j smaller
    }
    if ($t1 > max) {
      j bigger;
    }
    j minmax_loop;

smaller: 
    min = $t1;
    j minmax_loop;

bigger:
    max = $t1;
    j minmax_loop;
    
minmax_loop_exit:

int j=N;
print_loop:
  if j==0 j print_loop_exit
    printf("%d", A[j]);
    if (A[j] == max) printf(" (max) ");
    if (A[j] == min) printf(" (min) ");
    printf("\n");
  }
  j--:
print_loop_exit:
