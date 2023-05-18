# Momo Store aka Пельменная №2

<img width="900" alt="image" src="https://user-images.githubusercontent.com/9394918/167876466-2c530828-d658-4efe-9064-825626cc6db5.png">

## Ссылки для проверки проекта
- Сайт [Пельменной](https://momo-store.cloudns.ph/catalog)
- Панель [Grafana](https://grafana.momo-store.cloudns.ph/d/9rfE_dU4z/pel-mennaja?orgId=1&refresh=5s)
- Панель [Prometheus](https://prometheus.momo-store.cloudns.ph/targets?search=)

## Структура репозитория по папкам

- backend: 
  - Исходные коды бэкенда приложения на языке Go
  - Мультистейдж Dockerfile для сборки контейнера на базе исходных кодов
  - Конфиг файл .gitlab-ci.yml для CI/CD конвейера Gitlab
- frontend:
  - исходные коды фронтенда на языке JavaScript 
  - Мультистейдж Dockerfile для сборки контейнера на основе образа nginx
  - Конфиг файл .gitlab-ci.yml для CI/CD конвейера Gitlab
  - В папке nginx находится шаблон с конфигом где указаны эндпоинты бэкенда
- k8s-chart
  - Helm чарты для развертывания приложений Пельменной №2 и мониторинга в Kubernetes кластер 
  - Конфиг файл grafana/dashboards/kubernetes.json для импорта дашборда в Grafana
- terraform
  - Конфигурационные файлы для разворачивания кластера (Managed Service for Kubernetes в Яндекс облаке)
- В корневой папке находится основной конфиг файл .gitlab-ci.yml для CI/CD конвейера Gitlab


## Порядок развертывания приложения

- Яндекс облако
  - Войдите или создайте учетную запись в Яндекс [облаке](https://cloud.yandex.ru/)
  - Установите интерфейс командной строки [Yandex Cloud (CLI)](https://cloud.yandex.ru/docs/cli/quickstart#install)
  - Получите данные для аутентификации в облаке для управления инфраструктурой  с помощью [Terraform](https://cloud.yandex.ru/docs/tutorials/infrastructure-management/terraform-quickstart#get-credentials)
  - В консоли управления облаком создайте S3 бакеты:
    - с именем terraform-momo-store для хранения статуса terraform
    - с именем momo-store-artamokhin-aleksandr для хранения картинок с сайта Пельменной
  - Создайте сервисного [пользователя](https://cloud.yandex.ru/docs/iam/concepts/users/service-accounts) и статический ключ для него (нужен для файла backend.tf в папке terraform)
- Terraform
  - Скачайте Terraform из зеркала [Yandex.Cloud](https://hashicorp-releases.yandexcloud.net/terraform/)
  - После загрузки добавьте путь к папке с исполняемым файлом в переменную PATH:
  >export PATH=$PATH:/path/to/terraform
  - Укажите источник установки провайдера, добавив следующую конфигурацию в файл ~/.terraformrc (если такого файла нет на вашей машине, его нужно создать):
  ```hcl-terraform
  provider_installation {
    network_mirror {
      url = "https://terraform-mirror.yandexcloud.net/"
      include = ["registry.terraform.io/*/*"]
    }
    direct {
      exclude = ["registry.terraform.io/*/*"]
    }
  }
  ```
  - Перейдите в папку terraform/momo-store и запустите команды: 
    - terraform init
    - terraform plan (убедитесь в правильности конфигурации)
    - terraform apply
- Kubernetes
  - Создайте статический [ключ](https://cloud.yandex.ru/docs/managed-kubernetes/operations/connect/create-static-conf#prepare-cert) для доступа к кластеру
- SonarQube
  - Создайте или войдите в учетную запись SonarQube и создайте в нем проекты
    - momo-store-artamokhin
    - momo-store-backend-artamokhin
- Nexus
  - Создайте или войдите в репозиторий Nexus, создайте проект для хранения Helm чартов с именем "momo-store-helm-artamokhin-aleksandr-12"
- Gitlab
  - Добавьте в раздел CI/CD Settings - Variables следующие переменные
    - kubeconfig со значением из файла ~/.kube/config, закодированным по алгоритму base64
    - Переменные для статических тестов исходных кодов 
      - SonarQubeLogin
      - SonarQubeProjectMomo (линк на проект фронтенда)
      - SonarQubeProjectMomoBackend (линк на проект бэкенда)
      - SonarQubeToken
      - SonarQubeUrl
    - Переменные для хранилища артефактов Nexus
      - NEXUS_HELM_REPO
      - NEXUS_REPO_PASS
      - NEXUS_REPO_USER
    - dockerconfigjson (Секрет (в base64 формате), необходимый, чтобы взаимодействовать с Docker Registry в GitLab)
    - CHAT_ID (ID чата телеграм для отправки сообщений)
    - BOT_TOKEN (токен для доступа в телеграм)
- DNS
  - На сайте https://www.cloudns.net/ создайте доменные записи типа А с IP адресом Ingress контроллера (узнать можно с помощью команды: kubectl get ingress)
      - momo-store.cloudns.ph
      - grafana.momo-store.cloudns.ph
      - prometheus.momo-store.cloudns.ph
- Запуск CI/CD происходит:
  - в случае изменений в папках backend и frontend по полному циклу со сборкой и разворачиванием Helm чарта в k8s кластер
  - при изменениях в папке k8s-chart - только стадия Deploy из папки backend


