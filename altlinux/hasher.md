Конечно! Давайте рассмотрим **примеры использования Hasher** для сборки RPM-пакета в **Alt Linux**. Мы пройдем весь процесс от установки Hasher до сборки пакета.

---

### 1. Установка Hasher
Сначала установим Hasher и необходимые зависимости:
```bash
sudo apt-get install hasher rpm-build
```

---

### 2. Создание chroot-окружения
Инициализируем chroot-окружение для сборки:
```bash
sudo hasher-make-chroot
```
Эта команда создаст минимальную файловую систему в `/var/lib/hasher/chroot`.

---

### 3. Подготовка .spec файла
Для сборки RPM-пакета необходим `.spec` файл. Рассмотрим простой пример для программы "Hello World".

Создадим файл `hello.spec`:
```spec
Name:           hello
Version:        1.0
Release:        1%{?dist}
Summary:        A simple "Hello World" program

License:        GPLv3+
URL:            https://example.com
Source0:        hello-1.0.tar.gz

BuildRequires:  gcc, make
Requires:       bash

%description
A simple program that prints "Hello World".

%prep
%setup -q

%build
make

%install
mkdir -p %{buildroot}/usr/bin
install -m 755 hello %{buildroot}/usr/bin/hello

%files
/usr/bin/hello

%changelog
* Mon Mar 17 2025 Your Name <your.email@example.com> - 1.0-1
- Initial package.
```

---

### 4. Подготовка исходного кода
Создадим архив с исходным кодом программы "Hello World".

1. Создадим директорию `hello-1.0`:
   ```bash
   mkdir hello-1.0
   cd hello-1.0
   ```

2. Напишем простую программу на C (`hello.c`):
   ```c
   #include <stdio.h>

   int main() {
       printf("Hello World!\n");
       return 0;
   }
   ```

3. Создадим `Makefile`:
   ```makefile
   all:
       gcc -o hello hello.c
   ```

4. Создадим архив с исходным кодом:
   ```bash
   cd ..
   tar -czvf hello-1.0.tar.gz hello-1.0
   ```

---

### 5. Сборка пакета с помощью Hasher
Теперь соберем RPM-пакет.

1. Инициализируем среду сборки:
   ```bash
   sudo hasher --init
   ```

2. Запустим сборку пакета:
   ```bash
   sudo hasher --build /path/to/hello.spec
   ```
   Убедитесь, что архив `hello-1.0.tar.gz` и `hello.spec` находятся в одной директории.

3. Если сборка прошла успешно, RPM-пакет будет создан в `/var/lib/hasher/build/RPMS`.

---

### 6. Проверка собранного пакета
1. Найдите собранный пакет:
   ```bash
   ls /var/lib/hasher/build/RPMS/x86_64/
   ```
   Вы увидите файл, например, `hello-1.0-1.x86_64.rpm`.

2. Установите пакет для проверки:
   ```bash
   sudo rpm -ivh /var/lib/hasher/build/RPMS/x86_64/hello-1.0-1.x86_64.rpm
   ```

3. Запустите программу:
   ```bash
   hello
   ```
   Вывод:
   ```
   Hello World!
   ```

---

### 7. Очистка среды
После завершения сборки можно очистить среду:
```bash
sudo hasher --clean
```

---

### Пример вывода команд
#### Инициализация среды:
```bash
$ sudo hasher --init
Initializing hasher environment...
Done.
```

#### Сборка пакета:
```bash
$ sudo hasher --build /path/to/hello.spec
Building package hello-1.0...
Installing dependencies...
Compiling source code...
Packaging...
Done.
```

#### Проверка пакета:
```bash
$ rpm -qpl /var/lib/hasher/build/RPMS/x86_64/hello-1.0-1.x86_64.rpm
/usr/bin/hello
```

---

### Дополнительные примеры
#### Добавление пакетов в среду сборки
Если ваш пакет требует дополнительных зависимостей, добавьте их в chroot-окружение:
```bash
sudo hasher --add-pkg gcc-c++
```

#### Использование пользовательских конфигураций
Создайте конфигурационный файл `myconfig.cfg`:
```ini
[build]
arch = x86_64
release = 1
```
И используйте его при сборке:
```bash
sudo hasher --config /path/to/myconfig.cfg --build /path/to/hello.spec
```

---
Ссылки:

- [Hasher - основная статья](https://www.altlinux.org/%D0%9E_%D1%81%D1%82%D1%80%D0%B0%D1%82%D0%B5%D0%B3%D0%B8%D0%B8_%D1%81%D0%B1%D0%BE%D1%80%D0%BA%D0%B8_RPM_%D0%BF%D0%B0%D0%BA%D0%B5%D1%82%D0%BE%D0%B2)


### Заключение
Hasher — это мощный инструмент для сборки RPM-пакетов 
в изолированной среде. 
Он обеспечивает воспроизводимость и 
надежность сборок, что особенно важно
 для разработчиков и мейнтейнеров пакетов.