Установка **Docker Desktop** зависит от операционной системы, которую вы используете. Ниже приведены инструкции для установки Docker Desktop на **Windows**, **macOS** и **Linux**.

---

### **1. Установка Docker Desktop на Windows**

#### **Требования:**
- Windows 10 или 11 (64-битная версия).
- Поддержка виртуализации (Hyper-V или WSL 2).
- Минимум 4 ГБ оперативной памяти.

#### **Шаги:**
1. **Включите виртуализацию**:
   - Перезагрузите компьютер и войдите в BIOS/UEFI.
   - Включите виртуализацию (обычно называется Intel VT-x, AMD-V или SVM).

2. **Установите WSL 2 (если не установлен)**:
   - Откройте PowerShell от имени администратора и выполните:
     ```powershell
     wsl --install
     ```
   - Перезагрузите компьютер.

3. **Скачайте Docker Desktop**:
   - Перейдите на официальный сайт Docker: [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop).
   - Скачайте установщик для Windows.

4. **Установите Docker Desktop**:
   - Запустите скачанный установщик.
   - Следуйте инструкциям мастера установки.
   - По завершении установки Docker Desktop запустится автоматически.

5. **Проверка установки**:
   - Откройте командную строку или PowerShell.
   - Выполните команду:
     ```bash
     docker --version
     ```
   - Если установка прошла успешно, вы увидите версию Docker.

---

### **2. Установка Docker Desktop на macOS**

#### **Требования:**
- macOS 10.15 (Catalina) или новее.
- Процессор Intel или Apple Silicon (M1/M2).

#### **Шаги:**
1. **Скачайте Docker Desktop**:
   - Перейдите на официальный сайт Docker: [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop).
   - Скачайте установщик для macOS.

2. **Установите Docker Desktop**:
   - Откройте скачанный файл `.dmg`.
   - Перетащите значок Docker в папку "Applications".

3. **Запустите Docker Desktop**:
   - Перейдите в папку "Applications" и запустите Docker.
   - Следуйте инструкциям на экране для завершения настройки.

4. **Проверка установки**:
   - Откройте терминал.
   - Выполните команду:
     ```bash
     docker --version
     ```
   - Если установка прошла успешно, вы увидите версию Docker.

---

### **3. Установка Docker Desktop на Linux**

#### **Требования:**
- Поддерживаемые дистрибутивы: Ubuntu, Debian, Fedora, CentOS.
- Минимум 4 ГБ оперативной памяти.

#### **Шаги:**
1. **Скачайте Docker Desktop**:
   - Перейдите на официальный сайт Docker: [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop).
   - Скачайте установщик для Linux (DEB или RPM).

2. **Установите Docker Desktop**:
   - Для Ubuntu/Debian:
     ```bash
     sudo apt install ./docker-desktop-<version>.deb
     ```
   - Для Fedora/CentOS:
     ```bash
     sudo dnf install ./docker-desktop-<version>.rpm
     ```

3. **Запустите Docker Desktop**:
   - Найдите Docker Desktop в меню приложений и запустите его.
   - Следуйте инструкциям на экране для завершения настройки.

4. **Проверка установки**:
   - Откройте терминал.
   - Выполните команду:
     ```bash
     docker --version
     ```
   - Если установка прошла успешно, вы увидите версию Docker.

---

### **4. Настройка Docker Desktop**

После установки Docker Desktop:
1. **Войдите в Docker Hub**:
   - Создайте аккаунт на [Docker Hub](https://hub.docker.com/), если у вас его нет.
   - Войдите в аккаунт через Docker Desktop.

2. **Проверка работы**:
   - Запустите тестовый контейнер:
     ```bash
     docker run hello-world
     ```
   - Если всё работает, вы увидите сообщение "Hello from Docker!".

---

### **Ссылки:**
- Официальный сайт Docker Desktop: [https://www.docker.com/products/docker-desktop](https://www.docker.com/products/docker-desktop)
- Документация Docker: [https://docs.docker.com/](https://docs.docker.com/)

---
