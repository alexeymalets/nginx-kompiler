# Nginx Компилер

Скрипт, который поможет установить дополнительные модули Nginx без знания командной строки.

Для работы, Вам нужно будет выполнить несколько команд.

##Поддерживаемые ОС
* Debian 7,8
* Ubuntu 12,14,15,16

##Локализация
* Русский
* Английский

##Логика
* Определение дистрибутива
* Определение наличия установленного пакета
* Обновление системы
* Установка модулей Nginx(nchan, nginx-upload-progress-module, echo-nginx-module, nginx-rtmp-module и дополнительно другие)
* Перезапуск службы и вывод ошибки, если служба не запущена

##Запуск
Скачиваем архив со скриптом с GitHub
```
wget https://github.com/alexeymalets/nginx-kompiler/archive/master.zip
```
Распаковываем архив
```
unzip master.zip
```
Переходим в директорию со скриптом и устанавливаем права 777
```
cd nginx-kompiler-master && chmod 777 nginx_kompiler.sh
```
Запускаем скрипт
```
sh nginx_kompiler.sh
```
###Возможные проблемы при использовании
####1 unzip: command not found
```
#unzip master.zip
-bash: unzip: command not found
```
Для решения установите пакет unzip
#####Centos
```
yum install -y unzip
```
#####Debian/Ubuntu
```
apt-get install -y unzip
```
####2 ERROR: The certificate of 'github.com' is not trusted.
```
Connecting to github.com (github.com)|192.30.253.112|:443... connected.
ERROR: The certificate of 'github.com' is not trusted.
ERROR: The certificate of 'github.com' hasn't got a known issuer.
```
Для решения установите пакет ca-certificates
```
apt-get install -y ca-certificates
```

##Распространение
Лицензия GNU GPL

Автор не несёт ответственность за сбои, которые могут возникнут при использование скрипта. 

Вы используйте его на свой страх и риск.

##Партнёры
* Платное администрирование 24/7 https://myhosti.pro/
* Бесплатная помощь в администрировании http://svradmin.ru/