Чтобы создать `rootfs` для Alt Linux под архитектуру Эльбрус (e2k), используйте инструмент `mkimage-profile`. Вот пошаговая инструкция:

---

### 1. **Установите необходимые инструменты**
```bash
sudo apt-get update
sudo apt-get install mkimage-profile apt git
```

---

### 2. **Настройте репозитории для e2k**
Создайте файл `/etc/apt/sources.list.d/e2k.list`:
```bash
sudo tee /etc/apt/sources.list.d/e2k.list <<EOF
deb http://ftp.altlinux.org/pub/distributions/ALTLinux e2k main
EOF
```
Обновите список пакетов:
```bash
sudo apt-get update
```

---

### 3. **Создайте профиль для rootfs**
#### Структура профиля:
```bash
mkdir -p ~/e2k-rootfs/rootfs/{var/lib/apt,etc/apt}
cd ~/e2k-rootfs
```

---

### 4. **Настройка конфигурационных файлов**
#### a. Список пакетов (`rootfs/var/lib/apt/packages.list`):
```bash
echo "base-system
busybox
kernel-image-e2k
apt
iproute2
dhcp-client
elilo
elbrus-utils" > rootfs/var/lib/apt/packages.list
```

#### b. Репозитории внутри rootfs (`rootfs/etc/apt/sources.list`):
```bash
echo "deb http://ftp.altlinux.org/pub/distributions/ALTLinux e2k main" > rootfs/etc/apt/sources.list
```

#### c. Конфигурация mkimage (`mkimage.conf`):
```ini
[general]
arch = e2k
output = ./output
clean = 1

[rootfs]
profile = minimal
size = 1G
```

#### d. Скрипт пост-установки (`post-install.sh`):
```bash
#!/bin/sh
# Установка пароля root
echo "root:password" | chpasswd

# Настройка загрузчика elilo (пример)
elilo-install /dev/sda  # Замените /dev/sda на целевое устройство!
```

---

### 5. **Соберите rootfs**
```bash
mkimage -c mkimage.conf -p ~/e2k-rootfs --mirror="http://ftp.altlinux.org/pub/distributions/ALTLinux"
```
Готовый `rootfs` будет создан в папке `./output`.

---

### 6. **Проверка rootfs**
#### a. Войдите в chroot:
```bash
sudo chroot ./output/rootfs /bin/bash
```
#### b. Убедитесь, что базовые команды работают:
```bash
ls / && uname -a
```

---

### 7. **Дополнительная настройка (опционально)**
- **Добавьте пользователя**:
  ```bash
  useradd -m -s /bin/bash user
  echo "user:password" | chpasswd
  ```
- **Настройте сеть**:
  Создайте файл `/etc/network/interfaces`:
  ```bash
  auto eth0
  iface eth0 inet dhcp
  ```
- **Установите сервисы**:
  ```bash
  apt-get install openssh-server
  systemctl enable sshd
  ```

---

### 8. **Использование rootfs**
- **Для QEMU/эмуляции**:
  ```bash
  qemu-system-e2k -drive file=./output/alt.img,format=raw
  ```
- **Для реального железа**:
  ```bash
  dd if=./output/alt.img of=/dev/sdX bs=4M status=progress
  ```

---

### Возможные проблемы и решения
1. **Ошибка "Package not found"**:
   - Проверьте репозитории в `/etc/apt/sources.list`.
   - Убедитесь, что ветка `e2k` существует на зеркале.

2. **Некорректная работа загрузчика**:
   - Убедитесь, что пакет `elilo` установлен.
   - Проверьте конфигурацию `/etc/elilo.conf`.

3. **Недостаток места**:
   - Увеличьте значение `size` в `mkimage.conf`.

---

### Альтернативный метод (вручную)
Если требуется ручное создание `rootfs` без `mkimage-profile`:
```bash
# Создайте пустую директорию
mkdir rootfs

# Установите базовые пакеты через apt
sudo apt-get install -y --no-install-recommends \
    -o Dir::Etc::Sourcelist="sources.list" \
    -o Dir::Etc::SourceParts="" \
    -o APT::Architecture="e2k" \
    -o RootDir="rootfs" \
    base-system busybox

# Настройте остальные компоненты вручную
```

---

### Документация
- [Официальная документация mkimage](https://wiki.altlinux.org/MkImage)
- [Репозитории Alt Linux для e2k](https://mirrors.altlinux.org/)

После выполнения этих шагов вы получите минимальный `rootfs` для Alt Linux на архитектуре Эльбрус.


---


Чтобы создать загрузочный ISO-образ для Alt Linux (включая поддержку архитектуры **Эльбрус (e2k)**), выполните следующие шаги:

---

### 1. **Установите необходимые инструменты**
```bash
sudo apt-get update
sudo apt-get install mkisofs xorriso isolinux elilo
```

---

### 2. **Подготовьте структуру каталогов для ISO**
```bash
mkdir -p iso/{boot,rootfs}
```
- **`iso/boot`** — файлы загрузчика и ядра.
- **`iso/rootfs`** — корневая файловая система (скопируйте ваш `rootfs`).

---

### 3. **Скопируйте rootfs в ISO-структуру**
```bash
sudo cp -a /путь/к/rootfs/* iso/rootfs/
```

---

### 4. **Настройте загрузчик (для e2k используйте elilo)**
#### a. **Скопируйте ядро и initrd (если нужно)**:
```bash
sudo cp /boot/vmlinux iso/boot/  # Ядро для e2k
sudo cp /boot/initrd.img iso/boot/  # Initramfs (если используется)
```

#### b. **Создайте конфиг для elilo (`iso/boot/elilo.conf`)**:
```ini
prompt
timeout=50
image=/boot/vmlinux
    label=Alt Linux
    root=/dev/sr0  # Устройство CD-ROM
    initrd=/boot/initrd.img  # Опционально
    append="root=/dev/sr0 rootfstype=iso9660"
```

---

### 5. **Создайте ISO-образ**
```bash
mkisofs -o alt-e2k.iso \
    -b boot/elilo.efi \       # Загрузочный образ elilo (путь внутри ISO)
    -c boot/boot.cat \        # Файл загрузочного каталога
    -no-emul-boot \           # Отключить эмуляцию для UEFI
    -boot-load-size 4 \       # Размер загрузочного сектора
    -boot-info-table \
    -J -R -V "Alt Linux e2k" \
    iso/
```
**Пояснение опций**:
- `-b` — путь к загрузчику внутри ISO.
- `-J` — поддержка Joliet (для Windows).
- `-R` — Rock Ridge расширения (для Unix-прав).
- `-V` — метка тома.

---

### 6. **Проверьте ISO**
#### a. **Через QEMU** (если эмулятор поддерживает e2k):
```bash
qemu-system-e2k -cdrom alt-e2k.iso -boot d
```
#### b. **На реальном устройстве e2k**:
Запишите ISO на диск или флешку:
```bash
sudo dd if=alt-e2k.iso of=/dev/sdX bs=4M status=progress
```

---

### 7. **Специфика для e2k**
1. **Загрузчик elilo**:
   - Убедитесь, что файл `elilo.efi` скопирован в `iso/boot/`.  
     Обычно он находится в `/usr/lib/elilo/elilo.efi`.
   ```bash
   sudo cp /usr/lib/elilo/elilo.efi iso/boot/
   ```
2. **Ядро**:
   - Для e2k имя ядра может быть `vmlinux` (без расширения `.efi`).
3. **Проверьте пути**:
   - В `elilo.conf` укажите корректные пути к ядру и `initrd`.

---

### 8. **Автоматизация через mkimage-profile**
Если вы используете `mkimage-profile`, добавьте в профиль секцию для генерации ISO:
```ini
[iso]
output = ./output-iso
bootloader = elilo
```

Запустите сборку:
```bash
mkimage -c mkimage.conf -p ~/e2k-profile --format=iso
```

---

### 9. **Устранение ошибок**
- **Ошибка "No bootable medium found"**:
  - Убедитесь, что загрузочный сектор указан верно (`-b boot/elilo.efi`).
  - Проверьте наличие `elilo.efi` в ISO.
- **Ядро не загружается**:
  - Убедитесь, что ядро совместимо с архитектурой e2k.
  - Проверьте параметры `append` в `elilo.conf`.

---

### Пример готовой структуры ISO
```bash
iso/
├── boot/
│   ├── elilo.efi
│   ├── elilo.conf
│   ├── vmlinux
│   └── initrd.img
└── rootfs/
    ├── bin/
    ├── etc/
    └── ...
```

---

### Дополнительные ссылки
- [Документация elilo](https://wiki.altlinux.org/ELILO)
- [Alt Linux Wiki](https://wiki.altlinux.org/)

После выполнения этих шагов вы получите загрузочный ISO-образ для Alt Linux на архитектуре Эльбрус. Для других архитектур (x86_64, ARM) замените `elilo` на `grub` и настройте соответствующий загрузчик.


---

Чтобы добавить **systemd** в ваш дистрибутив Alt Linux (включая архитектуру Эльбрус), выполните следующие шаги:

---

### 1. **Убедитесь, что systemd доступен в репозитории**
Проверьте наличие пакета `systemd` для вашей архитектуры:
```bash
apt-cache search systemd
```
Если пакет отсутствует, обновите репозитории:
```bash
sudo apt-get update
```

---

### 2. **Добавьте systemd в список пакетов**
В файл `packages.list` вашего профиля добавьте:
```bash
systemd
systemd-sysvinit  # Для замены sysvinit (если используется)
dbus              # Зависимость systemd
udev              # Управление устройствами
```
Пример файла:
```bash
base-system
systemd
systemd-sysvinit
dbus
udev
...
```

---

### 3. **Пересоберите rootfs**
Если вы используете `mkimage-profile`, запустите сборку заново:
```bash
mkimage -c mkimage.conf -p ~/e2k-profile
```

---

### 4. **Настройте systemd как init по умолчанию**
В скрипте **post-install.sh** добавьте:
```bash
#!/bin/sh
# Установка systemd как init
ln -sf /usr/lib/systemd/systemd /sbin/init

# Активация базовых сервисов
systemctl preset-all
```

---

### 5. **Проверьте конфигурацию systemd**
После сборки войдите в `chroot`:
```bash
sudo chroot /путь/к/rootfs /bin/bash
```
Проверьте:
```bash
# Убедитесь, что systemd установлен
systemctl --version

# Проверьте, что systemd является init по умолчанию
ls -l /sbin/init
```

---

### 6. **Устранение ошибок**
- **Ошибка «Failed to connect to bus»**:
  Убедитесь, что `dbus` установлен и запущен:
  ```bash
  systemctl start dbus
  ```
- **Проблемы с загрузкой**:
  Убедитесь, что в `packages.list` включены:
  ```bash
  kernel-image-e2k
  systemd-udev
  ```

---

### 7. **Дополнительные настройки (опционально)**
- **Активация сервисов**:
  ```bash
  systemctl enable sshd network-manager
  ```
- **Настройка часового пояса**:
  ```bash
  ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
  ```

---

### 8. **Специфика для e2k**
Убедитесь, что пакеты `systemd` и `dbus` собраны для архитектуры Эльбрус. Если возникают ошибки:
1. Проверьте репозитории в `/etc/apt/sources.list`.
2. Убедитесь, что ветка репозитория (например, `e2k`, `p10`) поддерживает systemd.

---

### Пример готового `packages.list`
```bash
base-system
systemd
systemd-sysvinit
dbus
udev
kernel-image-e2k
iproute2
dhcp-client
```

---

После выполнения этих шагов **systemd** станет основной init-системой вашего дистрибутива. Для диагностики используйте:
```bash
journalctl -b  # Просмотр логов загрузки
systemctl list-unit-files  # Список сервисов
```

---


