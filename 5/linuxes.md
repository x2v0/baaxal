Кросс-сборка поддерживается во многих 
дистрибутивах Linux, и не только в **Альт 
Линукс**. Большинство современных дистрибутивов 
предоставляют инструменты для кросс-компиляции, 
такие как кросс-компиляторы, библиотеки и утилиты 
для сборки под различные архитектуры. Ниже 
приведен список популярных дистрибутивов, которые 
поддерживают кросс-сборку.

---

## 1. **Debian/Ubuntu**
Debian и его производные (например, Ubuntu) 
предоставляют широкие возможности для 
кросс-сборки благодаря своим репозиториям с 
кросс-компиляторами и библиотеками.

### Пример установки кросс-компилятора для ARM:
```bash
sudo apt-get install gcc-arm-linux-gnueabihf 
g++-arm-linux-gnueabihf
```

### Пример установки кросс-компилятора для AArch64:
```bash
sudo apt-get install gcc-aarch64-linux-gnu 
g++-aarch64-linux-gnu
```

### Поддерживаемые архитектуры:
- ARM (arm-linux-gnueabihf)
- AArch64 (aarch64-linux-gnu)
- MIPS (mips-linux-gnu)
- PowerPC (powerpc-linux-gnu)
- RISC-V (riscv64-linux-gnu)

---

## 2. **Fedora**
Fedora также предоставляет инструменты для 
кросс-сборки через свои репозитории.

### Пример установки кросс-компилятора для ARM:
```bash
sudo dnf install arm-linux-gnu-gcc 
arm-linux-gnu-gcc-c++
```

### Пример установки кросс-компилятора для AArch64:
```bash
sudo dnf install aarch64-linux-gnu-gcc 
aarch64-linux-gnu-gcc-c++
```

### Поддерживаемые архитектуры:
- ARM (arm-linux-gnu)
- AArch64 (aarch64-linux-gnu)
- MIPS (mips-linux-gnu)
- PowerPC (powerpc-linux-gnu)
- RISC-V (riscv64-linux-gnu)

---

## 3. **Arch Linux**
Arch Linux и его производные (например, Manjaro) 
предоставляют кросс-компиляторы через AUR (Arch User Repository) и официальные репозитории.

### Пример установки кросс-компилятора для ARM:
```bash
sudo pacman -S arm-linux-gnueabihf-gcc
```

### Пример установки кросс-компилятора для AArch64:
```bash
sudo pacman -S aarch64-linux-gnu-gcc
```

### Поддерживаемые архитектуры:
- ARM (arm-linux-gnueabihf)
- AArch64 (aarch64-linux-gnu)
- MIPS (mips-linux-gnu)
- PowerPC (powerpc-linux-gnu)
- RISC-V (riscv64-linux-gnu)

---

## 4. **OpenSUSE**
OpenSUSE предоставляет кросс-компиляторы через свои репозитории.

### Пример установки кросс-компилятора для ARM:
```bash
sudo zypper install cross-arm-linux-gnueabi-gcc
```

### Пример установки кросс-компилятора для AArch64:
```bash
sudo zypper install cross-aarch64-linux-gnu-gcc
```

### Поддерживаемые архитектуры:
- ARM (arm-linux-gnueabi)
- AArch64 (aarch64-linux-gnu)
- MIPS (mips-linux-gnu)
- PowerPC (powerpc-linux-gnu)
- RISC-V (riscv64-linux-gnu)

---

## 5. **Gentoo**
Gentoo предоставляет мощные инструменты для 
кросс-сборки через систему портежей (portage).

### Пример установки кросс-компилятора для ARM:
```bash
emerge cross-arm-linux-gnueabihf/gcc
```

### Пример установки кросс-компилятора для AArch64:
```bash
emerge cross-aarch64-linux-gnu/gcc
```

### Поддерживаемые архитектуры:
- ARM (arm-linux-gnueabihf)
- AArch64 (aarch64-linux-gnu)
- MIPS (mips-linux-gnu)
- PowerPC (powerpc-linux-gnu)
- RISC-V (riscv64-linux-gnu)

---

## 6. **Yocto Project**
Yocto — это не дистрибутив, а система для 
создания собственных дистрибутивов Linux, 
особенно для встраиваемых систем. Yocto 
поддерживает кросс-сборку для множества 
архитектур.

### Поддерживаемые архитектуры:
- ARM (armv7, armv8)
- AArch64
- MIPS
- PowerPC
- x86/x86_64
- RISC-V

### Пример использования:
Yocto использует `bitbake` для сборки пакетов и создания образов для целевых архитектур.

---

## 7. **Buildroot**
Buildroot — это еще один инструмент для создания 
встраиваемых Linux-систем. Он поддерживает 
кросс-сборку для множества архитектур.

### Поддерживаемые архитектуры:
- ARM (armv7, armv8)
- AArch64
- MIPS
- PowerPC
- x86/x86_64
- RISC-V

### Пример использования:
Buildroot автоматически настраивает 
кросс-компиляцию для выбранной архитектуры.

---

## 8. **Alpine Linux**
Alpine Linux — это минималистичный дистрибутив, 
который также поддерживает кросс-сборку.

### Пример установки кросс-компилятора для ARM:
```bash
apk add gcc-arm-linux-gnueabihf
```

### Пример установки кросс-компилятора для AArch64:
```bash
apk add gcc-aarch64-linux-gnu
```

### Поддерживаемые архитектуры:
- ARM (arm-linux-gnueabihf)
- AArch64 (aarch64-linux-gnu)
- x86/x86_64

---

## 9. **CentOS/RHEL**
CentOS и RHEL предоставляют кросс-компиляторы 
через дополнительные репозитории (например, EPEL).

### Пример установки кросс-компилятора для ARM:
```bash
sudo yum install arm-linux-gnu-gcc
```

### Пример установки кросс-компилятора для AArch64:
```bash
sudo yum install aarch64-linux-gnu-gcc
```

### Поддерживаемые архитектуры:
- ARM (arm-linux-gnu)
- AArch64 (aarch64-linux-gnu)
- PowerPC (powerpc-linux-gnu)

---

## Заключение
Почти все современные дистрибутивы Linux 
поддерживают кросс-сборку для различных 
архитектур. Выбор дистрибутива зависит от ваших 
предпочтений и задач. Если вы работаете с 
встраиваемыми системами, лучше использовать 
специализированные инструменты, такие как 
**Yocto** или **Buildroot**. Для настольных 
систем подойдут **Debian/Ubuntu**, **Fedora** или 
**Arch Linux**.
