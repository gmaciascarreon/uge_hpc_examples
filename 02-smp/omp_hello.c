#include <omp.h>
#include <stdio.h>
#include <unistd.h>

int main(void) {
    char host[256];
    gethostname(host, sizeof host);
    #pragma omp parallel
    {
        printf("host %s: thread %d of %d\n", host,
               omp_get_thread_num(), omp_get_num_threads());
    }
    return 0;
}
