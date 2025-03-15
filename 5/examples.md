Разработка компонентов кросс-сборки может быть 
проиллюстрирована на примере реальных проектов, 
где требуется сборка для различных архитектур 
(например, **aarch64**, **e2k**, **armv7**, 
**x86_64**). Ниже приведены примеры проектов и 
подходы к организации кросс-сборки для них.

---

## 1. **Проект: Встраиваемая система на базе ARM 
(aarch64)**

### Описание:
Разработка программного обеспечения для 
встраиваемого устройства на базе процессора 
**aarch64** (например, Raspberry Pi 4 или NVIDIA 
Jetson).

### Компоненты кросс-сборки:
- **Кросс-компилятор**: `gcc-aarch64-linux-gnu`.
- **Toolchain-файл**: Для настройки CMake.
- **Библиотеки**: Системные библиотеки для 
aarch64.
- **Тестирование**: QEMU для эмуляции aarch64.

### Пример:
1. **Установка кросс-компилятора**:
   ```bash
   sudo apt-get install gcc-aarch64-linux-gnu 
g++-aarch64-linux-gnu
   ```

2. **Создание toolchain-файла**:
   ```cmake
   # aarch64-linux-gnu.cmake
   set(CMAKE_SYSTEM_NAME Linux)
   set(CMAKE_SYSTEM_PROCESSOR aarch64)

   set(CMAKE_C_COMPILER aarch64-linux-gnu-gcc)
   set(CMAKE_CXX_COMPILER aarch64-linux-gnu-g++)

   set(CMAKE_FIND_ROOT_PATH 
/usr/aarch64-linux-gnu)
   set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
   set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
   set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
   set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
   ```

3. **Сборка проекта**:
   ```bash
   mkdir build-aarch64
   cd build-aarch64
   cmake 
-DCMAKE_TOOLCHAIN_FILE=../toolchains/aarch64-linux
-gnu.cmake ..
   make
   ```

4. **Тестирование с QEMU**:
   ```bash
   qemu-aarch64-static -L /usr/aarch64-linux-gnu 
./my-program
   ```

---

## 2. **Проект: Программное обеспечение для 
Эльбрус (e2k)**

### Описание:
Разработка ПО для процессоров **Эльбрус** 
(архитектура **e2k**), например, для серверов или 
специализированных вычислительных систем.

### Компоненты кросс-сборки:
- **Кросс-компилятор**: `lcc` 
(Эльбрус-компилятор).
- **Toolchain-файл**: Для настройки CMake.
- **Библиотеки**: Системные библиотеки для e2k.
- **Тестирование**: На реальном оборудовании или 
с использованием эмулятора.

### Пример:
1. **Установка компилятора**:
   Установите `lcc` из репозиториев Альт Линукс:
   ```bash
   sudo apt-get install lcc
   ```

2. **Создание toolchain-файла**:
   ```cmake
   # e2k-linux.cmake
   set(CMAKE_SYSTEM_NAME Linux)
   set(CMAKE_SYSTEM_PROCESSOR e2k)

   set(CMAKE_C_COMPILER lcc)
   set(CMAKE_CXX_COMPILER lcc++)

   set(CMAKE_FIND_ROOT_PATH /usr/e2k-linux)
   set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
   set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
   set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
   set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
   ```

3. **Сборка проекта**:
   ```bash
   mkdir build-e2k
   cd build-e2k
   cmake 
-DCMAKE_TOOLCHAIN_FILE=../toolchains/e2k-linux.cma
ke ..
   make
   ```

4. **Тестирование**:
   Перенесите собранный бинарный файл на 
устройство с архитектурой e2k и протестируйте.

---

## 3. **Проект: Кросс-платформенная библиотека 
(например, OpenSSL)**

### Описание:
Сборка библиотеки **OpenSSL** для различных 
архитектур (например, **aarch64**, **armv7**, 
**x86_64**).

### Компоненты кросс-сборки:
- **Кросс-компиляторы**: Для каждой целевой 
архитектуры.
- **Конфигурация**: Использование `./Configure` 
для настройки сборки.
- **Автоматизация**: Скрипты для сборки под 
разные архитектуры.

### Пример:
1. **Сборка для aarch64**:
   ```bash
   export CROSS_COMPILE=aarch64-linux-gnu-
   ./Configure linux-aarch64 
--prefix=/usr/aarch64-linux-gnu
   make
   make install
   ```

2. **Сборка для e2k**:
   ```bash
   export CC=lcc
   export CXX=lcc++
   ./Configure linux-e2k --prefix=/usr/e2k-linux
   make
   make install
   ```

---

## 4. **Проект: Встраиваемое приложение для 
ARMv7**

### Описание:
Разработка приложения для микроконтроллера на 
базе **ARMv7** (например, STM32).

### Компоненты кросс-сборки:
- **Кросс-компилятор**: `arm-none-eabi-gcc`.
- **Система сборки**: CMake или Make.
- **Библиотеки**: Стандартные библиотеки для 
ARMv7.

### Пример:
1. **Установка кросс-компилятора**:
   ```bash
   sudo apt-get install gcc-arm-none-eabi
   ```

2. **Создание toolchain-файла**:
   ```cmake
   # armv7-none-eabi.cmake
   set(CMAKE_SYSTEM_NAME Generic)
   set(CMAKE_SYSTEM_PROCESSOR arm)

   set(CMAKE_C_COMPILER arm-none-eabi-gcc)
   set(CMAKE_CXX_COMPILER arm-none-eabi-g++)

   set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
   set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
   set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
   set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
   ```

3. **Сборка проекта**:
   ```bash
   mkdir build-armv7
   cd build-armv7
   cmake 
-DCMAKE_TOOLCHAIN_FILE=../toolchains/armv7-none-ea
bi.cmake ..
   make
   ```

---

## 5. **Проект: Кросс-платформенный CI/CD 
пайплайн**

### Описание:
Автоматизация сборки и тестирования для 
нескольких архитектур с использованием GitLab CI.

### Компоненты:
- **CI/CD**: GitLab CI.
- **Контейнеризация**: Docker для изоляции сред 
сборки.
- **Артефакты**: Хранение собранных бинарных 
файлов.

### Пример конфигурации GitLab CI:
```yaml
stages:
  - build

build-aarch64:
  stage: build
  image: ubuntu:22.04
  script:
    - apt-get update && apt-get install -y 
gcc-aarch64-linux-gnu g++-aarch64-linux-gnu cmake
    - mkdir build && cd build
    - cmake 
-DCMAKE_TOOLCHAIN_FILE=../toolchains/aarch64-linux
-gnu.cmake ..
    - make
  artifacts:
    paths:
      - build/

build-e2k:
  stage: build
  image: altlinux/e2k
  script:
    - apt-get update && apt-get install -y lcc 
cmake
    - mkdir build && cd build
    - cmake 
-DCMAKE_TOOLCHAIN_FILE=../toolchains/e2k-linux.cma
ke ..
    - make
  artifacts:
    paths:
      - build/
```

---

## Заключение
Эти примеры демонстрируют, как можно организовать 
кросс-сборку для различных проектов и архитектур