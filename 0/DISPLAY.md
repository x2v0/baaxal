Если вы хотите, чтобы переменная окружения `DISPLAY` настраивалась автоматически при запуске WSL или SSH-сессии, есть несколько способов это реализовать. Вот основные подходы:

---

### **1. Автоматическая настройка `DISPLAY` в WSL**
Если вы используете WSL (Windows Subsystem for Linux), можно добавить команду `export DISPLAY` в файл конфигурации оболочки (например, `.bashrc`, `.zshrc` или `.profile`).

#### Шаги:
1. Откройте терминал WSL.
2. Откройте файл конфигурации вашей оболочки:
   - Для Bash:
     ```bash
     nano ~/.bashrc
     ```
   - Для Zsh:
     ```bash
     nano ~/.zshrc
     ```
3. Добавьте строку:
   ```bash
   export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
   ```
   Эта команда автоматически определяет IP-адрес хоста Windows и устанавливает его в переменную `DISPLAY`.

4. Сохраните файл и выйдите из редактора (в Nano: `Ctrl + X`, затем `Y` для подтверждения).
5. Перезагрузите оболочку или выполните:
   ```bash
   source ~/.bashrc  # или source ~/.zshrc
   ```

Теперь переменная `DISPLAY` будет автоматически настраиваться при каждом запуске WSL.

---

### **2. Автоматическая настройка `DISPLAY` для SSH**
Если вы подключаетесь к удаленному серверу через SSH и хотите автоматически настраивать `DISPLAY`, можно использовать SSH-клиент с поддержкой X11 Forwarding.

#### Шаги:
1. Включите X11 Forwarding в SSH-клиенте:
   - В PuTTY: Перейдите в **Connection -> SSH -> X11** и включите **Enable X11 forwarding**.
   - В OpenSSH (Linux/macOS): Используйте флаг `-X` или `-Y`:
     ```bash
     ssh -X user@remote_host
     ```
2. На удаленном сервере убедитесь, что переменная `DISPLAY` автоматически настраивается. Обычно SSH-сервер сам устанавливает эту переменную, но если это не происходит, добавьте в `.bashrc` или `.zshrc`:
   ```bash
   if [ -n "$SSH_CLIENT" ]; then
       export DISPLAY=$(echo $SSH_CLIENT | awk '{print $1}'):0
   fi
   ```

---

### **3. Использование `xauth` для автоматической аутентификации**
Если вы используете X Server на Windows (например, VcXsrv или Xming), убедитесь, что аутентификация X11 настроена правильно. Для этого:
1. Убедитесь, что на удаленном сервере установлен `xauth`:
   ```bash
   sudo apt install xauth  # Для Debian/Ubuntu
   sudo yum install xauth  # Для CentOS/RHEL
   ```
2. При подключении через SSH с X11 Forwarding, `xauth` автоматически создаст необходимые ключи.

---

### **4. Использование `~/.ssh/config` для автоматической настройки SSH**
Если вы часто подключаетесь к удаленным серверам, можно настроить SSH-клиент для автоматического включения X11 Forwarding.

#### Шаги:
1. Откройте файл `~/.ssh/config` (или создайте его, если он не существует):
   ```bash
   nano ~/.ssh/config
   ```
2. Добавьте конфигурацию для вашего сервера:
   ```bash
   Host remote_host
       HostName remote_host.example.com
       User your_username
       ForwardX11 yes
   ```
3. Теперь при подключении через SSH:
   ```bash
   ssh remote_host
   ```
   X11 Forwarding будет включен автоматически.

---

### **5. Использование `systemd` для автоматического запуска X Server (опционально)**
Если вы используете WSL2 и хотите автоматически запускать X Server при старте WSL, можно создать службу `systemd` (если она включена в вашей версии WSL).

#### Шаги:
1. Убедитесь, что `systemd` включен в WSL:
   ```bash
   sudo nano /etc/wsl.conf
   ```
   Добавьте строки:
   ```ini
   [boot]
   systemd=true
   ```
2. Создайте службу для запуска X Server:
   ```bash
   sudo nano /etc/systemd/system/xserver.service
   ```
   Добавьте содержимое:
   ```ini
   [Unit]
   Description=X Server for WSL

   [Service]
   ExecStart=/mnt/c/path/to/vcxsrv.exe :0 -ac -multiwindow
   Restart=always

   [Install]
   WantedBy=default.target
   ```
3. Включите и запустите службу:
   ```bash
   sudo systemctl enable xserver
   sudo systemctl start xserver
   ```

---

### **Итог**
- Для **WSL**: Добавьте `export DISPLAY` в `.bashrc` или `.zshrc`.
- Для **SSH**: Используйте `ForwardX11 yes` в `~/.ssh/config`.
- Для **автоматического запуска X Server**: Настройте службу `systemd` (если доступно).

