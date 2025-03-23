Приведем больше примеров использования **Alt Build** для сборки различных типов проектов на платформе **Альт Линукс**. Эти примеры охватывают сборку простых программ, проектов с библиотеками, кросс-компиляцию и другие сценарии.

---

## Пример 1: Простой проект на C

### 1. **Структура проекта**

```
my_project/
├── my_project.spec
├── my_project-1.0.tar.gz
└── src/
    └── main.c
```

### 2. **`main.c`**

```c
#include <stdio.h>

int main() {
    printf("Hello, Alt Build!\n");
    return 0;
}
```

### 3. **`my_project.spec`**

```spec
Name:           my_project
Version:        1.0
Release:        1%{?dist}
Summary:        Пример простого проекта на C

License:        MIT
URL:            https://example.com
Source0:        %{name}-%{version}.tar.gz

BuildRequires:  gcc, make
Requires:       libc

%description
Пример простого проекта на C, собранного с использованием Alt Build.

%prep
%setup -q

%build
make %{?_smp_mflags}

%install
mkdir -p %{buildroot}%{_bindir}
install -m 755 src/main %{buildroot}%{_bindir}/my_program

%files
%{_bindir}/my_program

%changelog
* Пн Мар 16 2025 Ваше Имя <ваш-email@example.com> - 1.0-1
- Первая сборка проекта.
```

### 4. **Сборка**

```bash
tar -czvf my_project-1.0.tar.gz my_project/
mkdir -p ~/rpmbuild/SOURCES
cp my_project-1.0.tar.gz ~/rpmbuild/SOURCES/
alt-build -ba my_project.spec
```

---

## Пример 2: Проект с библиотекой

### 1. **Структура проекта**

```
my_project/
├── my_project.spec
├── my_project-1.0.tar.gz
├── src/
│   ├── main.c
│   └── Makefile
└── lib/
    ├── mylib.c
    └── mylib.h
```

### 2. **`lib/mylib.c`**

```c
#include "mylib.h"

int add(int a, int b) {
    return a + b;
}
```

### 3. **`lib/mylib.h`**

```c
#ifndef MYLIB_H
#define MYLIB_H

int add(int a, int b);

#endif
```

### 4. **`src/main.c`**

```c
#include <stdio.h>
#include "../lib/mylib.h"

int main() {
    int result = add(5, 3);
    printf("5 + 3 = %d\n", result);
    return 0;
}
```

### 5. **`src/Makefile`**

```makefile
CC = gcc
CFLAGS = -I../lib

all: my_program

my_program: main.c
    $(CC) $(CFLAGS) -o my_program main.c ../lib/mylib.c

clean:
    rm -f my_program
```

### 6. **`my_project.spec`**

```spec
Name:           my_project
Version:        1.0
Release:        1%{?dist}
Summary:        Пример проекта с библиотекой

License:        MIT
URL:            https://example.com
Source0:        %{name}-%{version}.tar.gz

BuildRequires:  gcc, make
Requires:       libc

%description
Пример проекта с библиотекой, собранного с использованием Alt Build.

%prep
%setup -q

%build
make -C src %{?_smp_mflags}

%install
mkdir -p %{buildroot}%{_bindir}
install -m 755 src/my_program %{buildroot}%{_bindir}/my_program

%files
%{_bindir}/my_program

%changelog
* Пн Мар 16 2025 Ваше Имя <ваш-email@example.com> - 1.0-1
- Первая сборка проекта.
```

### 7. **Сборка**

```bash
tar -czvf my_project-1.0.tar.gz my_project/
mkdir -p ~/rpmbuild/SOURCES
cp my_project-1.0.tar.gz ~/rpmbuild/SOURCES/
alt-build -ba my_project.spec
```

---

## Пример 3: Кросс-компиляция для МКОМ-03

### 1. **Структура проекта**

```
my_project/
├── my_project.spec
├── my_project-1.0.tar.gz
└── src/
    └── main.c
```

### 2. **`main.c`**

```c
#include <stdio.h>

int main() {
    printf("Hello, МКОМ-03!\n");
    return 0;
}
```

### 3. **`my_project.spec`**

```spec
Name:           my_project
Version:        1.0
Release:        1%{?dist}
Summary:        Пример кросс-компиляции для МКОМ-03

License:        MIT
URL:            https://example.com
Source0:        %{name}-%{version}.tar.gz

BuildRequires:  gcc-mkom-03, make
Requires:       libc

%description
Пример кросс-компиляции для МКОМ-03, собранного с использованием Alt Build.

%prep
%setup -q

%build
make %{?_smp_mflags} CC=mkom-03-gcc

%install
mkdir -p %{buildroot}%{_bindir}
install -m 755 src/main %{buildroot}%{_bindir}/my_program

%files
%{_bindir}/my_program

%changelog
* Пн Мар 16 2025 Ваше Имя <ваш-email@example.com> - 1.0-1
- Первая сборка проекта.
```

### 4. **Сборка**

```bash
tar -czvf my_project-1.0.tar.gz my_project/
mkdir -p ~/rpmbuild/SOURCES
cp my_project-1.0.tar.gz ~/rpmbuild/SOURCES/
alt-build --target=mkom03 -ba my_project.spec
```

---

## Пример 4: Проект с использованием pkg-config

### 1. **Структура проекта**

```
my_project/
├── my_project.spec
├── my_project-1.0.tar.gz
└── src/
    └── main.c
```

### 2. **`main.c`**

```c
#include <gtk/gtk.h>

int main(int argc, char *argv[]) {
    gtk_init(&argc, &argv);
    GtkWidget *window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
    gtk_window_set_title(GTK_WINDOW(window), "Hello, GTK!");
    gtk_widget_show_all(window);
    gtk_main();
    return 0;
}
```

### 3. **`my_project.spec`**

```spec
Name:           my_project
Version:        1.0
Release:        1%{?dist}
Summary:        Пример проекта с использованием GTK

License:        MIT
URL:            https://example.com
Source0:        %{name}-%{version}.tar.gz

BuildRequires:  gcc, make, pkgconfig(gtk+-3.0)
Requires:       gtk3

%description
Пример проекта с использованием GTK, собранного с использованием Alt Build.

%prep
%setup -q

%build
make %{?_smp_mflags} PKG_CONFIG_PATH=%{_libdir}/pkgconfig

%install
mkdir -p %{buildroot}%{_bindir}
install -m 755 src/main %{buildroot}%{_bindir}/my_program

%files
%{_bindir}/my_program

%changelog
* Пн Мар 16 2025 Ваше Имя <ваш-email@example.com> - 1.0-1
- Первая сборка проекта.
```

### 4. **Сборка**

```bash
tar -czvf my_project-1.0.tar.gz my_project/
mkdir -p ~/rpmbuild/SOURCES
cp my_project-1.0.tar.gz ~/rpmbuild/SOURCES/
alt-build -ba my_project.spec
```

---

## Заключение

Эти примеры демонстрируют различные сценарии использования **Alt Build** для сборки проектов на платформе **Альт Линукс**. Вы можете адаптировать их под свои нужды, добавляя специфические настройки для процессоров **МКОМ-03** и других архитектур. Если у вас возникнут вопросы, обратитесь к документации Alt Build и RPM.