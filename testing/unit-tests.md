Добавление **юнит-тестов** в проект — это важная часть разработки программного обеспечения. Юнит-тесты позволяют проверить корректность работы отдельных модулей или функций. В этом руководстве мы рассмотрим, как добавить юнит-тесты в проект на **Альт Линукс**, используя популярные фреймворки для тестирования, такие как **Check** (для C) и **Google Test** (для C++). Также мы интегрируем тесты в процесс сборки с использованием **Autotools**, **CMake** и **Meson**.

---

## Пример 1: Юнит-тесты на C с использованием **Check**

### 1. **Установка Check**

Установите библиотеку **Check** для написания и запуска юнит-тестов на C:

```bash
sudo apt-get install check
```

### 2. **Структура проекта**

```
my_project/
├── src/
│   ├── main.c
│   └── math.c
├── tests/
│   ├── test_math.c
│   └── CMakeLists.txt
├── CMakeLists.txt
└── meson.build
```

### 3. **`src/math.c`**

```c
int add(int a, int b) {
    return a + b;
}
```

### 4. **`src/math.h`**

```c
#ifndef MATH_H
#define MATH_H

int add(int a, int b);

#endif
```

### 5. **`tests/test_math.c`**

```c
#include <check.h>
#include "../src/math.h"

START_TEST(test_add) {
    ck_assert_int_eq(add(2, 3), 5);
    ck_assert_int_eq(add(-1, 1), 0);
}
END_TEST

Suite *math_suite(void) {
    Suite *s;
    TCase *tc_core;

    s = suite_create("Math");

    tc_core = tcase_create("Core");
    tcase_add_test(tc_core, test_add);
    suite_add_tcase(s, tc_core);

    return s;
}

int main(void) {
    int number_failed;
    Suite *s;
    SRunner *sr;

    s = math_suite();
    sr = srunner_create(s);

    srunner_run_all(sr, CK_NORMAL);
    number_failed = srunner_ntests_failed(sr);
    srunner_free(sr);

    return (number_failed == 0) ? 0 : 1;
}
```

### 6. **Интеграция с CMake**

Добавьте поддержку тестов в `CMakeLists.txt`:

```cmake
cmake_minimum_required(VERSION 3.10)
project(MyProject C)

# Настройка основного проекта
add_library(math STATIC src/math.c)
add_executable(my_program src/main.c)
target_link_libraries(my_program math)

# Настройка тестов
find_package(Check REQUIRED)
add_executable(test_math tests/test_math.c)
target_link_libraries(test_math math Check::Check)
enable_testing()
add_test(NAME math_test COMMAND test_math)
```

### 7. **Сборка и запуск тестов**

```bash
mkdir build
cd build
cmake ..
make
ctest
```

---

## Пример 2: Юнит-тесты на C++ с использованием **Google Test**

### 1. **Установка Google Test**

Установите Google Test:

```bash
sudo apt-get install libgtest-dev
```

### 2. **Структура проекта**

```
my_project/
├── src/
│   ├── main.cpp
│   └── math.cpp
├── tests/
│   ├── test_math.cpp
│   └── CMakeLists.txt
├── CMakeLists.txt
└── meson.build
```

### 3. **`src/math.cpp`**

```cpp
int add(int a, int b) {
    return a + b;
}
```

### 4. **`src/math.h`**

```cpp
#ifndef MATH_H
#define MATH_H

int add(int a, int b);

#endif
```

### 5. **`tests/test_math.cpp`**

```cpp
#include <gtest/gtest.h>
#include "../src/math.h"

TEST(MathTest, Add) {
    EXPECT_EQ(add(2, 3), 5);
    EXPECT_EQ(add(-1, 1), 0);
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
```

### 6. **Интеграция с CMake**

Добавьте поддержку Google Test в `CMakeLists.txt`:

```cmake
cmake_minimum_required(VERSION 3.10)
project(MyProject CXX)

# Настройка основного проекта
add_library(math STATIC src/math.cpp)
add_executable(my_program src/main.cpp)
target_link_libraries(my_program math)

# Настройка тестов
find_package(GTest REQUIRED)
add_executable(test_math tests/test_math.cpp)
target_link_libraries(test_math math GTest::GTest GTest::Main)
enable_testing()
add_test(NAME math_test COMMAND test_math)
```

### 7. **Сборка и запуск тестов**

```bash
mkdir build
cd build
cmake ..
make
ctest
```

---

## Пример 3: Юнит-тесты с использованием **Meson**

### 1. **Структура проекта**

```
my_project/
├── src/
│   ├── main.c
│   └── math.c
├── tests/
│   └── test_math.c
└── meson.build
```

### 2. **`meson.build`**

```meson
project('my_project', 'c',
  version : '1.0',
  default_options : ['warning_level=3'])

# Основной проект
math_lib = static_library('math', 'src/math.c')
executable('my_program', 'src/main.c', link_with : math_lib)

# Тесты
check_dep = dependency('check')
test_math = executable('test_math', 'tests/test_math.c',
                       link_with : math_lib,
                       dependencies : check_dep)
test('math_test', test_math)
```

### 3. **Сборка и запуск тестов**

```bash
meson setup build
cd build
meson compile
meson test
```

---

## Пример 4: Юнит-тесты с использованием **Autotools**

### 1. **Структура проекта**

```
my_project/
├── src/
│   ├── main.c
│   └── math.c
├── tests/
│   └── test_math.c
├── configure.ac
└── Makefile.am
```

### 2. **`configure.ac`**

```m4
AC_INIT([my_project], [1.0], [your-email@example.com])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])
AC_PROG_CC

# Проверка наличия Check
PKG_CHECK_MODULES([CHECK], [check >= 0.9.0])

AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([Makefile src/Makefile tests/Makefile])
AC_OUTPUT
```

### 3. **`src/Makefile.am`**

```makefile
lib_LIBRARIES = libmath.a
libmath_a_SOURCES = math.c
```

### 4. **`tests/Makefile.am`**

```makefile
check_PROGRAMS = test_math
test_math_SOURCES = test_math.c
test_math_LDADD = ../src/libmath.a $(CHECK_LIBS)
TESTS = test_math
```

### 5. **Сборка и запуск тестов**

```bash
autoreconf --install
./configure
make
make check
```

---

## Заключение

Добавление юнит-тестов в проект — это важный шаг для обеспечения качества кода. Мы рассмотрели, как интегрировать тесты в проекты на C и C++ с использованием популярных фреймворков (**Check**, **Google Test**) и систем сборки (**CMake**, **Meson**, **Autotools**). Следуя этим примерам, вы сможете легко добавить тестирование в свои проекты на **Альт Линукс**.