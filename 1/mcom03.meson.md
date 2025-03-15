Сборка программного обеспечения с использованием **Meson** и **Ninja** — это современный и эффективный подход, который становится все более популярным. Meson — это система сборки, которая проста в использовании и поддерживает кросс-компиляцию, а Ninja — это быстрый и легковесный инструмент для выполнения сборки. В этом руководстве мы рассмотрим, как использовать Meson и Ninja для сборки проектов на платформе **Альт Линукс** для процессоров **МКОМ-03**.

---

## 1. **Установка Meson и Ninja**

Для начала установите Meson и Ninja в вашей системе. В **Альт Линукс** это можно сделать с помощью пакетного менеджера:

```bash
sudo apt-get update
sudo apt-get install meson ninja-build
```

Если вы работаете с кросс-компиляцией, установите кросс-компилятор для **МКОМ-03**:

```bash
sudo apt-get install gcc-mkom-03
```

(Здесь `gcc-mkom-03` — пример названия пакета. Уточните точное название для вашей версии Альт Линукс.)

---

## 2. **Создание проекта Meson**

Meson использует файл `meson.build` для описания конфигурации проекта. Рассмотрим несколько примеров.

---

### Пример 1: Простой проект

#### 1. **Структура проекта**

```
my_project/
├── meson.build
└── main.c
```

#### 2. **`meson.build`**

```meson
project('my_project', 'c',
  version : '1.0',
  default_options : ['warning_level=3'])

executable('my_program',
           'main.c',
           install : true)
```

#### 3. **`main.c`**

```c
#include <stdio.h>

int main() {
    printf("Hello, Meson!\n");
    return 0;
}
```

#### 4. **Сборка проекта**

1. Создайте директорию для сборки:

   ```bash
   mkdir build
   cd build
   ```

2. Настройте проект с помощью Meson:

   ```bash
   meson setup ..
   ```

3. Соберите проект с помощью Ninja:

   ```bash
   ninja
   ```

4. Установите проект (опционально):

   ```bash
   sudo ninja install
   ```

---

### Пример 2: Проект с использованием библиотек

Предположим, ваш проект использует внешнюю библиотеку, например, `libm` (математическую библиотеку).

#### 1. **`meson.build`**

```meson
project('my_project', 'c',
  version : '1.0',
  default_options : ['warning_level=3'])

cc = meson.get_compiler('c')
m_dep = cc.find_library('m', required : true)

executable('my_program',
           'main.c',
           dependencies : m_dep,
           install : true)
```

#### 2. **`main.c`**

```c
#include <stdio.h>
#include <math.h>

int main() {
    double result = sqrt(25.0);
    printf("Square root of 25 is: %f\n", result);
    return 0;
}
```

#### 3. **Сборка**

```bash
mkdir build
cd build
meson setup ..
ninja
```

---

### Пример 3: Проект с подкаталогами

Если ваш проект состоит из нескольких подкаталогов, например, `src` и `lib`, настройка будет выглядеть следующим образом.

#### 1. **Структура проекта**

```
my_project/
├── meson.build
├── src/
│   ├── meson.build
│   └── main.c
└── lib/
    ├── meson.build
    ├── mylib.c
    └── mylib.h
```

#### 2. **Корневой `meson.build`**

```meson
project('my_project', 'c',
  version : '1.0',
  default_options : ['warning_level=3'])

subdir('lib')
subdir('src')
```

#### 3. **`lib/meson.build`**

```meson
mylib_sources = ['mylib.c', 'mylib.h']

mylib = static_library('mylib',
                       mylib_sources,
                       install : true)

mylib_dep = declare_dependency(link_with : mylib,
                               include_directories : include_directories('.'))
```

#### 4. **`src/meson.build`**

```meson
executable('my_program',
           'main.c',
           dependencies : mylib_dep,
           install : true)
```

#### 5. **`lib/mylib.c`**

```c
#include "mylib.h"

int add(int a, int b) {
    return a + b;
}
```

#### 6. **`lib/mylib.h`**

```c
#ifndef MYLIB_H
#define MYLIB_H

int add(int a, int b);

#endif
```

#### 7. **`src/main.c`**

```c
#include <stdio.h>
#include "../lib/mylib.h"

int main() {
    int result = add(5, 3);
    printf("5 + 3 = %d\n", result);
    return 0;
}
```

#### 8. **Сборка**

```bash
mkdir build
cd build
meson setup ..
ninja
```

---

### Пример 4: Кросс-компиляция для МКОМ-03

Для кросс-компиляции необходимо создать файл конфигурации, который описывает целевую платформу.

#### 1. **Файл кросс-компиляции (`mkom-03-cross.txt`)**

```ini
[binaries]
c = 'mkom-03-gcc'
cpp = 'mkom-03-g++'
ar = 'mkom-03-ar'
strip = 'mkom-03-strip'

[host_machine]
system = 'linux'
cpu_family = 'mkom03'
cpu = 'mkom03'
endian = 'little'
```

#### 2. **Настройка и сборка**

```bash
mkdir build
cd build
meson setup --cross-file ../mkom-03-cross.txt ..
ninja
```

---

## 3. **Преимущества Meson и Ninja**

- **Простота**: Meson использует простой и понятный синтаксис.
- **Скорость**: Ninja — это очень быстрый инструмент сборки.
- **Кросс-компиляция**: Meson отлично поддерживает кросс-компиляцию.
- **Переносимость**: Meson работает на всех основных платформах.

---

## 4. **Заключение**

Использование **Meson** и **Ninja** для сборки проектов на платформе **Альт Линукс** для процессоров **МКОМ-03** — это современный и эффективный подход. Следуя приведенным примерам, вы сможете настроить и собрать свои проекты с минимальными усилиями. Если у вас возникнут вопросы, обратитесь к официальной документации Meson и Ninja.