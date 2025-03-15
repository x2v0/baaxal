Кросс-компиляция с использованием CMake — это процесс сборки программного обеспечения для целевой платформы (например, встраиваемой системы или мобильного устройства), которая отличается от платформы, на которой выполняется сборка (например, ваш ПК или сервер). Это часто используется в разработке для ARM, AArch64, MIPS, RISC-V и других архитектур.

В этом руководстве я подробно расскажу, как настроить и использовать CMake для кросс-компиляции.

---

### 1. **Установка кросс-компилятора**
Для кросс-компиляции вам понадобится кросс-компилятор, который поддерживает целевую архитектуру. Например:
- Для ARM: `gcc-arm-none-eabi`, `arm-linux-gnueabihf-gcc`
- Для AArch64: `aarch64-linux-gnu-gcc`
- Для MIPS: `mips-linux-gnu-gcc`
- Для RISC-V: `riscv64-unknown-elf-gcc`

Установите кросс-компилятор с помощью пакетного менеджера вашей системы. Например, для ARM на Ubuntu:
```bash
sudo apt install gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf
```

---

### 2. **Создание файла инструментов (Toolchain File)**
Файл инструментов (Toolchain File) — это файл CMake, который определяет настройки для кросс-компиляции. В нем указываются:
- Кросс-компиляторы (C, C++).
- Целевая система (например, Linux, Windows, bare-metal).
- Пути к библиотекам и заголовкам целевой системы.

Пример файла `toolchain-arm-linux.cmake`:
```cmake
# Целевая система
set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

# Пути к кросс-компиляторам
set(CMAKE_C_COMPILER arm-linux-gnueabihf-gcc)
set(CMAKE_CXX_COMPILER arm-linux-gnueabihf-g++)

# Путь к корневой файловой системе целевой платформы (если есть)
set(CMAKE_FIND_ROOT_PATH /path/to/target/sysroot)

# Настройка поиска библиотек и заголовков
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)  # Ищем программы только на хосте
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)   # Ищем библиотеки только в целевой системе
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)   # Ищем заголовки только в целевой системе
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)   # Ищем пакеты только в целевой системе
```

Здесь:
- `CMAKE_SYSTEM_NAME` — имя целевой операционной системы (например, `Linux`, `Windows`, `Android`).
- `CMAKE_SYSTEM_PROCESSOR` — архитектура целевой системы (например, `arm`, `aarch64`, `x86_64`).
- `CMAKE_C_COMPILER` и `CMAKE_CXX_COMPILER` — пути к кросс-компиляторам.
- `CMAKE_FIND_ROOT_PATH` — путь к корневой файловой системе целевой платформы (если используется).

---

### 3. **Настройка проекта с использованием файла инструментов**
Чтобы использовать файл инструментов, передайте его в CMake при настройке проекта:
```bash
cmake -S . -B build -DCMAKE_TOOLCHAIN_FILE=/path/to/toolchain-arm-linux.cmake
```

Здесь:
- `-S .` — исходный код проекта в текущей директории.
- `-B build` — директория для сборки.
- `-DCMAKE_TOOLCHAIN_FILE` — путь к файлу инструментов.

---

### 4. **Сборка проекта**
После настройки проекта выполните сборку:
```bash
cmake --build build
```

Собранные бинарные файлы будут предназначены для целевой платформы.

---

### 5. **Дополнительные настройки**
#### Указание флагов компиляции и линковки
Вы можете добавить флаги компиляции и линковки в файл инструментов или в командной строке. Например:
```cmake
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -march=armv7-a -mfpu=neon")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=armv7-a -mfpu=neon")
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static")
```

#### Использование библиотек целевой системы
Если у вас есть библиотеки и заголовки для целевой системы, укажите их путь в `CMAKE_FIND_ROOT_PATH`. Например:
```cmake
set(CMAKE_FIND_ROOT_PATH /path/to/target/sysroot)
```

---

### 6. **Пример: Кросс-компиляция для ARM Linux**
1. Установите кросс-компилятор:
   ```bash
   sudo apt install gcc-arm-linux-gnueabihf g++-arm-linux-gnueabihf
   ```

2. Создайте файл инструментов `toolchain-arm-linux.cmake`:
   ```cmake
   set(CMAKE_SYSTEM_NAME Linux)
   set(CMAKE_SYSTEM_PROCESSOR arm)
   set(CMAKE_C_COMPILER arm-linux-gnueabihf-gcc)
   set(CMAKE_CXX_COMPILER arm-linux-gnueabihf-g++)
   set(CMAKE_FIND_ROOT_PATH /path/to/target/sysroot)
   ```

3. Настройте и соберите проект:
   ```bash
   cmake -S . -B build -DCMAKE_TOOLCHAIN_FILE=toolchain-arm-linux.cmake
   cmake --build build
   ```

---

### 7. **Тестирование**
Если у вас есть доступ к целевой платформе, перенесите собранные бинарные файлы и протестируйте их. Например:
```bash
scp build/my_program user@target:/path/to/destination
ssh user@target /path/to/destination/my_program
```

---

### 8. **Советы и рекомендации**
- **Используйте эмуляторы**: Если у вас нет доступа к целевой платформе, используйте эмуляторы, такие как QEMU, для тестирования.
- **Статическая линковка**: Если целевая система не имеет всех необходимых библиотек, используйте статическую линковку:
  ```cmake
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} -static")
  ```
- **Проверка зависимостей**: Убедитесь, что все зависимости (библиотеки, заголовки) доступны для целевой платформы.

---

### Пример для встраиваемых систем (bare-metal)
Для встраиваемых систем (без операционной системы) настройки могут отличаться. Пример файла инструментов для ARM Cortex-M:
```cmake
set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(CMAKE_C_COMPILER arm-none-eabi-gcc)
set(CMAKE_CXX_COMPILER arm-none-eabi-g++)

set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mcpu=cortex-m4 -mthumb -specs=nosys.specs")
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mcpu=cortex-m4 -mthumb -specs=nosys.specs")
```
