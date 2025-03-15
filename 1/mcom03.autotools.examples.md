Приведем еще несколько примеров использования **Autotools** для сборки проектов, включая более сложные сценарии, такие как использование библиотек, создание статических и динамических библиотек, а также работа с подкаталогами. Эти примеры помогут вам лучше понять, как настраивать проекты для сборки на платформе **Альт Линукс** для процессоров **МКОМ-03**.

---

## Пример 1: Проект с использованием внешней библиотеки

Предположим, ваш проект использует внешнюю библиотеку, например, `libm` (математическую библиотеку).

### 1. **`configure.ac`**

```m4
AC_INIT([my_project], [1.0], [your-email@example.com])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])
AC_PROG_CC

# Проверка наличия библиотеки math (libm)
AC_CHECK_LIB([m], [sqrt])

AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
```

### 2. **`Makefile.am`**

```makefile
bin_PROGRAMS = my_program
my_program_SOURCES = main.c
my_program_LDADD = -lm  # Связываем с библиотекой math
```

### 3. **`main.c`**

```c
#include <stdio.h>
#include <math.h>

int main() {
    double result = sqrt(25.0);
    printf("Square root of 25 is: %f\n", result);
    return 0;
}
```

### 4. **Сборка**

```bash
autoreconf --install
./configure --host=mkom-03-linux-gnu CC=mkom-03-gcc
make
```

---

## Пример 2: Проект с подкаталогами

Если ваш проект состоит из нескольких подкаталогов, например, `src` и `lib`, настройка будет выглядеть следующим образом.

### 1. **Структура проекта**

```
my_project/
├── configure.ac
├── Makefile.am
├── src/
│   ├── main.c
│   └── Makefile.am
└── lib/
    ├── mylib.c
    ├── mylib.h
    └── Makefile.am
```

### 2. **`configure.ac`**

```m4
AC_INIT([my_project], [1.0], [your-email@example.com])
AM_INIT_AUTOMAKE([-Wall -Werror foreign subdir-objects])
AC_PROG_CC

AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([Makefile src/Makefile lib/Makefile])
AC_OUTPUT
```

### 3. **Корневой `Makefile.am`**

```makefile
SUBDIRS = lib src
```

### 4. **`src/Makefile.am`**

```makefile
bin_PROGRAMS = my_program
my_program_SOURCES = main.c
my_program_LDADD = ../lib/libmylib.a  # Связываем с библиотекой из подкаталога lib
```

### 5. **`lib/Makefile.am`**

```makefile
noinst_LIBRARIES = libmylib.a
libmylib_a_SOURCES = mylib.c mylib.h
```

### 6. **`lib/mylib.c`**

```c
#include "mylib.h"

int add(int a, int b) {
    return a + b;
}
```

### 7. **`lib/mylib.h`**

```c
#ifndef MYLIB_H
#define MYLIB_H

int add(int a, int b);

#endif
```

### 8. **`src/main.c`**

```c
#include <stdio.h>
#include "../lib/mylib.h"

int main() {
    int result = add(5, 3);
    printf("5 + 3 = %d\n", result);
    return 0;
}
```

### 9. **Сборка**

```bash
autoreconf --install
./configure --host=mkom-03-linux-gnu CC=mkom-03-gcc
make
```

---

## Пример 3: Создание статической и динамической библиотеки

Если ваш проект создает библиотеку, которую можно использовать в других проектах, настройка будет следующей.

### 1. **`configure.ac`**

```m4
AC_INIT([my_library], [1.0], [your-email@example.com])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])
AC_PROG_CC
AC_PROG_RANLIB  # Для статических библиотек
LT_INIT([disable-shared])  # Инициализация libtool (только статические библиотеки)
AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
```

### 2. **`Makefile.am`**

```makefile
lib_LTLIBRARIES = libmylib.la  # Динамическая библиотека
libmylib_la_SOURCES = mylib.c mylib.h

noinst_LIBRARIES = libmylib.a  # Статическая библиотека
libmylib_a_SOURCES = mylib.c mylib.h
```

### 3. **`mylib.c`**

```c
#include "mylib.h"

int multiply(int a, int b) {
    return a * b;
}
```

### 4. **`mylib.h`**

```c
#ifndef MYLIB_H
#define MYLIB_H

int multiply(int a, int b);

#endif
```

### 5. **Сборка**

```bash
autoreconf --install
./configure --host=mkom-03-linux-gnu CC=mkom-03-gcc
make
```

После сборки вы получите:
- Статическую библиотеку: `libmylib.a`
- Динамическую библиотеку: `libmylib.la`

---

## Пример 4: Использование pkg-config для зависимостей

Если ваш проект зависит от библиотек, которые предоставляют файлы `.pc` для `pkg-config`, вы можете использовать их в `configure.ac`.

### 1. **`configure.ac`**

```m4
AC_INIT([my_project], [1.0], [your-email@example.com])
AM_INIT_AUTOMAKE([-Wall -Werror foreign])
AC_PROG_CC

# Проверка наличия pkg-config
PKG_CHECK_MODULES([MYLIB], [mylib >= 1.0])

AC_CONFIG_HEADERS([config.h])
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
```

### 2. **`Makefile.am`**

```makefile
bin_PROGRAMS = my_program
my_program_SOURCES = main.c
my_program_CFLAGS = $(MYLIB_CFLAGS)
my_program_LDADD = $(MYLIB_LIBS)
```

### 3. **`main.c`**

```c
#include <mylib.h>

int main() {
    mylib_function();
    return 0;
}
```

### 4. **Сборка**

```bash
autoreconf --install
./configure --host=mkom-03-linux-gnu CC=mkom-03-gcc
make
```

---

## Заключение

Эти примеры демонстрируют различные сценарии использования **Autotools** для сборки проектов. Вы можете адаптировать их под свои нужды, добавляя специфические настройки для процессоров **МКОМ-03** и платформы **Альт Линукс**. Если у вас возникнут вопросы, обращайтесь к документации Autotools и кросс-компиляции.