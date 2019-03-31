# dchirkov_infra
dchirkov Infra repository

## ДЗ к занятию 5
### SSH-подключение к внутреннему хосту в одну команду
Подключение к не имеющей внешнего доступа ВМ *someinternalhost (10.154.0.3)* с локального компьютера через ВМ *bastion (35.205.222.9)* можно набрав команду:
````
ssh -J dmitry_n_chirkov@35.205.222.9 dmitry_n_chirkov@10.154.0.3
````

\* опция -J появилась в версии OpenSSH 7.3

### SSH-подключение к внутреннему хосту по алиасу
Для подключения по алиасу нужно создать config-файл пользователя на локальной машине:

````
$ cat .ssh/config 
Host bastion
   HostName 35.205.222.9
   User dmitry_n_chirkov
Host someinternalhost
   HostName 10.154.0.3
   ProxyJump bastion
   User dmitry_n_chirkov 
````

### Подключение по VPN
Конфигурация файла setupvpn.sh изменена на версию Ubuntu 18.04 (bionic).
Подключение к VPN осуществляется по доменному имени bastion-vpn.linux.technology
Установен сертификат Let's Encrypt.

Данные для подключения:
````
bastion_IP = 35.205.222.9
someinternalhost_IP = 10.154.0.3
````

## ДЗ к занятию 6
Данные для подключения:
````
testapp_IP = 35.240.16.90
testapp_port = 9292
````

### Создание ВМ с автозапуском скрипта
````
gcloud compute instances create reddit-app --boot-disk-size=10GB \
--image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud \
--machine-type=g1-small --tags puma-server --restart-on-failure \
--metadata-from-file startup-script=dchirkov_infra/startup_script.sh \ 
--zone europe-west1-b
````

### Создание правила файервола посредством команды gcloud
````
gcloud compute firewall-rules create default-puma-server --allow=tcp:9292 --target-tags puma-server
````

## ДЗ к занятию 7
Сделано:
* Создан шаблон ubuntu16 для packer с приложениями ruby и mongodb
* Создано семейство образов reddit-base в Google Cloud средствами packer
* Создан шаблон immutable для packer с нашим приложением reddit
* Настроен автозапуск приложения reddit
* Создано семейство образов reddit-full в Google Cloud средствами packer

## ДЗ к занятию 8
### Описание задания со *:
При добавлении ssh-keys других пользователей средствами terraform в ВМ добавляется последний пользователь в коде.

При добавлении ssh-ключа пользователя appuser_web в веб-интерфейсе в метаданные проекта, в ВМ создается пользователь, но
при применении terraform apply никаких изменений не происходит (ручные операции с ВМ не видны терраформу).

### Описание задания со **:
При добавлении балансировщика перед приложением мы повышаем его отказоустойчивость.

При добавлении ВМ с помощью ресурса google_compute_instance мы увеличиваем сложность и поддерживаемость кода.  

Количество однотипных ресурсов задается параметром count, ресурс вызывается следующим образом:
```` 
<resource>.<name>.<numcount>
````
