**CI/CD** (Continuous Integration / Continuous Delivery) — это практика автоматизации процессов интеграции кода, тестирования и доставки приложений. В этом руководстве мы рассмотрим, как настроить **CI/CD** для проекта на **Альт Линукс** с использованием популярных инструментов, таких как **GitLab CI/CD**, **GitHub Actions** и **Jenkins**.

---

## Пример 1: Настройка CI/CD с использованием **GitLab CI/CD**

### 1. **Структура проекта**

```
my_project/
├── src/
│   ├── main.c
│   └── math.c
├── tests/
│   └── test_math.c
├── .gitlab-ci.yml
└── CMakeLists.txt
```

### 2. **`.gitlab-ci.yml`**

```yaml
stages:
  - build
  - test

build:
  stage: build
  script:
    - mkdir build
    - cd build
    - cmake ..
    - make
  artifacts:
    paths:
      - build/my_program

test:
  stage: test
  script:
    - cd build
    - ctest --output-on-failure
```

### 3. **Как это работает**
- **Этап `build`**: Собирает проект с использованием CMake.
- **Этап `test`**: Запускает юнит-тесты с помощью `ctest`.
- **Артефакты**: Сохраняет собранный бинарный файл для дальнейшего использования.

---

## Пример 2: Настройка CI/CD с использованием **GitHub Actions**

### 1. **Структура проекта**

```
my_project/
├── src/
│   ├── main.c
│   └── math.c
├── tests/
│   └── test_math.c
├── .github/workflows/ci.yml
└── CMakeLists.txt
```

### 2. **`.github/workflows/ci.yml`**

```yaml
name: CI

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2

      - name: Install dependencies
        run: sudo apt-get update && sudo apt-get install -y cmake build-essential check

      - name: Build project
        run: |
          mkdir build
          cd build
          cmake ..
          make

      - name: Run tests
        run: |
          cd build
          ctest --output-on-failure
```

### 3. **Как это работает**
- **Триггеры**: Запускается при пуше в ветку `main` или создании pull request.
- **Установка зависимостей**: Устанавливает CMake, компилятор и библиотеку Check.
- **Сборка и тестирование**: Собирает проект и запускает тесты.

---

## Пример 3: Настройка CI/CD с использованием **Jenkins**

### 1. **Установка Jenkins**
Установите Jenkins на сервер **Альт Линукс**:

```bash
sudo apt-get update
sudo apt-get install openjdk-11-jdk
wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | sudo apt-key add -
sudo sh -c 'echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list'
sudo apt-get update
sudo apt-get install jenkins
```

### 2. **Настройка Jenkins Pipeline**
Создайте файл `Jenkinsfile` в корне проекта:

```groovy
pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                sh '''
                    mkdir build
                    cd build
                    cmake ..
                    make
                '''
            }
        }
        stage('Test') {
            steps {
                sh '''
                    cd build
                    ctest --output-on-failure
                '''
            }
        }
    }

    post {
        success {
            echo 'Build and tests completed successfully!'
        }
        failure {
            echo 'Build or tests failed!'
        }
    }
}
```

### 3. **Как это работает**
- **Этап `Build`**: Собирает проект с использованием CMake.
- **Этап `Test`**: Запускает юнит-тесты с помощью `ctest`.
- **Уведомления**: Выводит сообщение об успешной или неудачной сборке.

---

## Пример 4: Настройка CI/CD с использованием **GitLab CI/CD** для кросс-компиляции

### 1. **Структура проекта**

```
my_project/
├── src/
│   ├── main.c
│   └── math.c
├── tests/
│   └── test_math.c
├── .gitlab-ci.yml
└── CMakeLists.txt
```

### 2. **`.gitlab-ci.yml`**

```yaml
stages:
  - build
  - test

variables:
  CC: mkom-03-gcc
  CXX: mkom-03-g++

build:
  stage: build
  script:
    - mkdir build
    - cd build
    - cmake ..
    - make
  artifacts:
    paths:
      - build/my_program

test:
  stage: test
  script:
    - cd build
    - ctest --output-on-failure
```

### 3. **Как это работает**
- **Кросс-компиляция**: Указывается кросс-компилятор для **МКОМ-03**.
- **Сборка и тестирование**: Собирает проект и запускает тесты.

---

## Пример 5: Настройка CI/CD с использованием **GitHub Actions** для кросс-компиляции

### 1. **Структура проекта**

```
my_project/
├── src/
│   ├── main.c
│   └── math.c
├── tests/
│   └── test_math.c
├── .github/workflows/ci.yml
└── CMakeLists.txt
```

### 2. **`.github/workflows/ci.yml`**

```yaml
name: CI

on:
  push:
    branches:
      - main
  pull_request:
    branches:
      - main

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2

      - name: Install dependencies
        run: sudo apt-get update && sudo apt-get install -y cmake build-essential gcc-mkom-03

      - name: Build project
        run: |
          mkdir build
          cd build
          cmake -DCMAKE_C_COMPILER=mkom-03-gcc -DCMAKE_CXX_COMPILER=mkom-03-g++ ..
          make

      - name: Run tests
        run: |
          cd build
          ctest --output-on-failure
```

### 3. **Как это работает**
- **Кросс-компиляция**: Устанавливается кросс-компилятор для **МКОМ-03**.
- **Сборка и тестирование**: Собирает проект и запускает тесты.

---

## Заключение

Настройка **CI/CD** для проектов на **Альт Линукс** позволяет автоматизировать процессы сборки, тестирования и доставки. Мы рассмотрели примеры использования **GitLab CI/CD**, **GitHub Actions** и **Jenkins**, а также добавили поддержку кросс-компиляции для процессоров **МКОМ-03**. Следуя этим примерам, вы сможете легко настроить CI/CD для своих проектов.