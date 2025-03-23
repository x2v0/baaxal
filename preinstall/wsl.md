Для установки WSL 2 (Windows Subsystem for Linux 2) на Windows 10 или Windows 11, выполните следующие шаги:

### 1. **Проверьте требования**
   - Убедитесь, что у вас установлена **Windows 10 версии 2004 и выше** или **Windows 11**.
   - Ваш процессор должен поддерживать виртуализацию (Intel VT-x или AMD-V).

### 2. **Включите компоненты WSL и виртуализацию**
   - Откройте PowerShell от имени администратора и выполните следующие команды:
     ```powershell
     wsl --install
     ```
     Эта команда автоматически установит WSL 2, включит необходимые компоненты и установит Ubuntu по умолчанию.

   Если команда `wsl --install` недоступна, выполните вручную:
   ```powershell
   dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
   dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
   ```
   - Перезагрузите компьютер.

### 3. **Установите ядро WSL 2**
   - Скачайте и установите обновление ядра WSL 2 с официального сайта Microsoft:  
     [https://aka.ms/wsl2kernel](https://aka.ms/wsl2kernel)

### 4. **Установите дистрибутив Linux**
   - Откройте Microsoft Store и выберите дистрибутив Linux (например, Ubuntu, Debian, Kali Linux).
   - Установите его.

### 5. **Настройте WSL 2 как версию по умолчанию**
   - Откройте PowerShell от имени администратора и выполните:
     ```powershell
     wsl --set-default-version 2
     ```

### 6. **Проверка установки**
   - Запустите установленный дистрибутив Linux из меню "Пуск".
   - После завершения настройки проверьте версию WSL:
     ```powershell
     wsl --list --verbose
     ```
     Убедитесь, что ваш дистрибутив использует WSL 2.

### 7. **Обновление WSL (опционально)**
   - Для обновления WSL до последней версии выполните:
     ```powershell
     wsl --update
     ```


Готово! Теперь у вас установлен WSL 2, и вы можете использовать Linux на Windows.