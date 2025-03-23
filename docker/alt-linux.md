Запуск **Docker** и **udocker** в **ALT Linux** имеет свои особенности, так как ALT Linux — это российский дистрибутив Linux, основанный на SUSE и ориентированный на стабильность и безопасность. Ниже приведены инструкции по установке и запуску Docker и udocker в ALT Linux.

---

## **1. Установка и запуск Docker в ALT Linux**

### **Требования:**
- ALT Linux Sisyphus или другой поддерживаемый релиз.
- Права суперпользователя (root).

### **Шаги:**

1. **Обновите систему**:
   ```bash
   sudo apt-get update
   sudo apt-get upgrade
   ```

2. **Установите Docker**:
   - Установите необходимые пакеты:
     ```bash
     sudo apt-get install docker.io
     ```
   - Docker будет установлен вместе с зависимостями.

3. **Запустите и добавьте Docker в автозагрузку**:
   ```bash
   sudo systemctl start docker
   sudo systemctl enable docker
   ```

4. **Проверка установки**:
   - Проверьте версию Docker:
     ```bash
     docker --version
     ```
   - Запустите тестовый контейнер:
     ```bash
     sudo docker run hello-world
     ```

5. **Настройка прав для пользователя** (опционально):
   - Чтобы не использовать `sudo` для Docker, добавьте текущего пользователя в группу `docker`:
     ```bash
     sudo usermod -aG docker $USER
     ```
   - Перезагрузите систему или выйдите и войдите снова.

---

## **2. Установка и запуск udocker в ALT Linux**

### **Требования:**
- ALT Linux Sisyphus или другой поддерживаемый релиз.
- Python 3 (обычно предустановлен в ALT Linux).

### **Шаги:**

1. **Скачайте udocker**:
   - Перейдите на официальный репозиторий udocker: [https://github.com/indigo-dc/udocker](https://github.com/indigo-dc/udocker).
   - Скачайте скрипт:
     ```bash
     curl https://raw.githubusercontent.com/indigo-dc/udocker/master/udocker.py > udocker
     chmod +x udocker
     ```

2. **Установите udocker**:
   - Запустите установку:
     ```bash
     ./udocker install
     ```
   - Скрипт установит необходимые зависимости и настроит окружение.

3. **Проверка установки**:
   - Проверьте версию udocker:
     ```bash
     ./udocker --version
     ```

4. **Использование udocker**:
   - Загрузите Docker-образ:
     ```bash
     ./udocker pull ubuntu:latest
     ```
   - Запустите контейнер:
     ```bash
     ./udocker run ubuntu:latest echo "Hello, udocker!"
     ```

---

## **3. Особенности ALT Linux**

- **Пакетный менеджер**: ALT Linux использует `apt-get` (как в Debian/Ubuntu), но пакеты могут отличаться.
- **Поддержка контейнеров**: ALT Linux поддерживает Docker, но для udocker могут потребоваться дополнительные зависимости (например, `PRoot` или `Fakechroot`).
- **Безопасность**: ALT Linux ориентирован на безопасность, поэтому некоторые функции Docker могут быть ограничены (например, использование `seccomp`).

---

## **4. Полезные команды**

### **Для Docker:**
- Запуск контейнера:
  ```bash
  sudo docker run -it ubuntu:latest
  ```
- Просмотр запущенных контейнеров:
  ```bash
  sudo docker ps
  ```
- Остановка контейнера:
  ```bash
  sudo docker stop <container_id>
  ```

### **Для udocker:**
- Список образов:
  ```bash
  ./udocker images
  ```
- Удаление контейнера:
  ```bash
  ./udocker rm <container_id>
  ```

---

## **5. Ссылки**

- Официальный сайт ALT Linux: [https://www.altlinux.org/](https://www.altlinux.org/)
- Официальный репозиторий udocker: [https://github.com/indigo-dc/udocker](https://github.com/indigo-dc/udocker)
- Документация Docker: [https://docs.docker.com/](https://docs.docker.com)