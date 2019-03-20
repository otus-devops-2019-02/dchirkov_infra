# dchirkov_infra
dchirkov Infra repository

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
