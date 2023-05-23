#include <stdio.h>
#include <pthread.h>

#define NUM_THREADS 6

// Общая переменная для хранения результатов факториалов
unsigned long long factorial_results[NUM_THREADS];

// Функция для выполнения вычислений в параллельном процессе
void* compute_factorial(void* arg) {
    unsigned long long result = 1;
    int number = *(int*)arg;

    for (int i = 1; i <= number; i++) {
        result *= i;
    }
    // Сохраняем результат в общей переменной
    factorial_results[number - 1] = result;

    pthread_exit(NULL);
}

int main() {
    pthread_t threads[NUM_THREADS];
    int thread_args[NUM_THREADS];

    // Создаем параллельные потоки
    for (int i = 0; i < NUM_THREADS; i++) {
        thread_args[i] = i + 1;
        pthread_create(&threads[i], NULL, compute_factorial, &thread_args[i]);
    }
    // Дожидаемся завершения всех потоков
    for (int i = 0; i < NUM_THREADS; i++) {
        pthread_join(threads[i], NULL);
    }

    // Выводим результаты факториалов
    for (int i = 0; i < NUM_THREADS; i++) {
        printf("%d! = %llu\n", i + 1, factorial_results[i]);
    }

    return 0;
}