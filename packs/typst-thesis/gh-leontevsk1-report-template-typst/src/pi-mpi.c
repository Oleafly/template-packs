// Подключение необходимых заголовков
#include <stdio.h>
#include <math.h>
// Подключение заголовочного файла MPI
#include "mpi.h"
// Функция для промежуточных вычислений
double f(double a) {return (4.0 / (1.0+ a*a));}
// Главная функция программы
int main(int argc, char **argv) {
    // Объявление переменных
    int done = 0, n, myid, numprocs, i;
    double PI25DT = 3.141592653589793238462643;
    double mypi, pi, h, sum, x;
    double startwtime = 0.0, endwtime;
    int namelen;
    char processor_name[MPI_MAX_PROCESSOR_NAME];
    // Инициализация подсистемы MPI
    MPI_Init(&argc, &argv);
    // Получить размер коммуникатора MPI_COMM_WORLD
    // (общее число процессов в рамках задачи)
    MPI_Comm_size(MPI_COMM_WORLD,&numprocs);
    // Получить номер текущего процесса в рамках 
    // коммуникатора MPI_COMM_WORLD
    MPI_Comm_rank(MPI_COMM_WORLD,&myid);
    MPI_Get_processor_name(processor_name,&namelen);
    // Вывод номера потока в общем пуле
    fprintf(stdout, "Process %d of %d is on %s\n", myid,numprocs,processor_name);
    fflush(stdout);
    while(!done) {
        // количество интервалов
        if (myid==0) {
            fprintf(stdout, "Enter the number of intervals: (0 quits) ");
            fflush(stdout);
            if (scanf("%d",&n) != 1) {
                fprintf(stdout, "No number entered; quitting\n");
                n = 0;
            }
            startwtime = MPI_Wtime();
        }
        // Рассылка количества интервалов всем процессам (в том числе и себе)
        MPI_Bcast(&n, 1, MPI_INT, 0, MPI_COMM_WORLD);
        if (n==0) done = 1;
        else {
            h = 1.0 / (double) n;
            sum = 0.0;
            // Обсчитывание точки, закрепленной за процессом
            for (i = myid + 1 ; (i <= n) ; i += numprocs) {
                x = h * ((double)i - 0.5);
                sum += f(x);
            }
            mypi = h * sum;
            // Сброс результатов со всех процессов и сложение
            MPI_Reduce(&mypi, &pi, 1, MPI_DOUBLE, MPI_SUM, 0, MPI_COMM_WORLD);
            // Если это главный процесс, вывод полученного результата
            if (myid==0) {
                printf("PI is approximately %.16f, Error is %.16f\n", pi, fabs(pi - PI25DT));
                endwtime = MPI_Wtime();
                printf("wall clock time =%f\n", endwtime-startwtime);
                fflush(stdout);
            }
        }
    }
    // Освобождение подсистемы MPI
    MPI_Finalize();
    return 0;
}
