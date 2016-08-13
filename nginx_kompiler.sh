#!/bin/sh
#Support https://github.com/alexeymalets/nginx-kompiler
#Soft Nginx kompiler
#Installing modules Nginx
#Author Alex Malets
#GNU GPL license

clear
#Detect lang
loc_none_script='Unfortunately, the script is Nginx Install/Upgrade auto your OS does not support'
loc_your_os='Your OS';
loc_no_install_nginx='You have not installed Nginx!'
loc_yes='Yes'
loc_no='No'
loc_up_ug_system='Run the system update?'
loc_choose='Choose'
loc_install_module='Installing modules Nginx nchan, nginx-upload-progress-module, echo-nginx-module и nginx-rtmp-module?'
loc_det_v_nginx='Determine the configuration of Nginx'
loc_mkdir_mod='Create a directory under modules'
loc_go_to_dir='Go to directory'
loc_dow_mod='Downloading module'
loc_unpack='Unzip modules'
loc_delete_zip='Removing archive'
loc_add_pack_nginx='Get installed package Nginx'
loc_mkdir_dir='Create directory'
loc_remove_dir='Removing directory'
loc_install_pak='Install additional packages'
loc_conf_pak='Configure Nginx'
loc_conf_install_pak='Install the assembled package Nginx'
loc_restart_nginx='Restart Nginx'
loc_status_nginx='Check the status of the service'
loc_upgrade_nginx_sf='Nginx successfully recompiled'
loc_upgrade_nginx_faild='Unfortunately, at the time of compilation problems, so service is not running. To solve the problem, you can write to:'
loc_srv_admin='Free help with server administration'
loc_myhosti='Support your servers 24/7'
loc_error='Error'
loc_thanks_soft='Thank you for using this software!'
loc_install_last_v_nginx='To install the latest version of Nginx?'
loc_down_nginx_install_auto='Download the script nginx-install-auto'
loc_run_script='Run script'
#Spechil sim

#Detect OS

#OS Version Ubuntu 16
if [ "$(cat /etc/*-release | grep xenial)" ]; then
	dist=ubuntu
	osv=xenial
#OS Version Ubuntu 15
elif [ "$(cat /etc/*-release | grep wily)" ]; then
	dist=ubuntu
	osv=wily
	dist=ubuntu
#OS Version Ubuntu 14
elif [ "$(cat /etc/*-release | grep trusty)" ]; then
	dist=ubuntu
	osv=trusty
#OS Version Ubuntu 12
elif [ "$(cat /etc/*-release | grep precise)" ]; then
	dist=ubuntu
	osv=precise
#OS Version Debian 8
elif [ "$(cat /etc/*-release | grep jessie)" ]; then
	dist=debian
	osv=jessie
#OS Version Debian 7
elif [ "$(cat /etc/*-release | grep wheezy)" ]; then
	dist=debian
	osv=wheezy
else
	echo "${loc_none_script}!"
	exit 0
fi

echo "${loc_your_os} ${dist} ${osv}"

#Check install nginx
checknginxstatus=0

nginx_modules_install(){
		echo "${loc_up_ug_system}"
		echo "1) ${loc_yes}"
		echo "2) ${loc_no}"
		read -p "${loc_choose}: " upgrade_packet_system
		if [ $upgrade_packet_system -eq 1 ]; then
			apt-get update && apt-get -y upgrade
		fi
		echo "${loc_install_module}"
		echo "1) ${loc_yes}"
		echo "2) ${loc_no}"
		read -p "${loc_choose}: " install_module_nginx
		if [ $install_module_nginx -eq 1 ]; then
			echo "${loc_mkdir_mod} /etc/nginx/kompiler"
			mkdir /etc/nginx/kompiler
			
			echo "${loc_go_to_dir} /etc/nginx/kompiler"
			cd /etc/nginx/kompiler
			
			echo "${loc_dow_mod} Nchan"
			wget https://github.com/slact/nchan/archive/master.zip
			echo "${loc_unpack}"
			if [ -z "$(dpkg -l | grep unzip)" ]; then
				apt-get install -y unzip
			fi
			unzip master.zip
			echo "${loc_delete_zip} master.zip"
			rm -rf master.zip
			
			echo "${loc_dow_mod} nginx-upload-progress-module"
			wget https://github.com/masterzen/nginx-upload-progress-module/archive/master.zip
			echo "${loc_unpack}"
			unzip master.zip
			
			echo "${loc_delete_zip} master.zip"
			rm -rf master.zip
			
			echo "${loc_dow_mod} echo-nginx-module"
			wget https://github.com/openresty/echo-nginx-module/archive/master.zip
			echo "${loc_unpack}"
			unzip master.zip
			
			echo "${loc_delete_zip} master.zip"
			rm -rf master.zip
			
			echo "${loc_dow_mod} nginx-rtmp-module"
			wget https://github.com/arut/nginx-rtmp-module/archive/master.zip
			echo "${loc_unpack}"
			unzip master.zip
			
			echo "${loc_delete_zip} master.zip"
			rm -rf master.zip
			
			echo "${loc_go_to_dir}"
			cd
			
			echo "${loc_mkdir_dir}"
			mkdir nginxtmp 
			
			echo "${loc_go_to_dir} nginxtmp"
			cd nginxtmp
			
			echo "${loc_add_pack_nginx}"
			apt-get source nginx
			
			echo "${loc_unpack}"
			tar -xvzf nginx*.tar.gz
			
			echo "${loc_go_to_dir} Nginx"
			cd nginx*
			
			echo "${loc_go_to_dir} Nginx"
			
			echo "${loc_install_pak}"
			apt-get -y install build-essential libpcre3 libpcre3-dev openssl libssl-dev libxml2-dev libxslt-dev libgd-dev libgeoip-dev libperl-dev
			
			echo "${loc_install_pak}"
			./configure  --prefix=/etc/nginx --sbin-path=/usr/sbin/nginx --modules-path=/usr/lib/nginx/modules --conf-path=/etc/nginx/nginx.conf --error-log-path=/var/log/nginx/error.log --http-log-path=/var/log/nginx/access.log --pid-path=/var/run/nginx.pid --lock-path=/var/run/nginx.lock --http-client-body-temp-path=/var/cache/nginx/client_temp --http-proxy-temp-path=/var/cache/nginx/proxy_temp --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp --http-scgi-temp-path=/var/cache/nginx/scgi_temp --user=nginx --group=nginx --with-http_ssl_module --with-http_realip_module --with-http_addition_module --with-http_sub_module --with-http_dav_module --with-http_flv_module --with-http_mp4_module --with-http_gunzip_module --with-http_gzip_static_module --with-http_random_index_module --with-http_secure_link_module --with-http_stub_status_module --with-http_auth_request_module --with-http_xslt_module=dynamic --with-http_image_filter_module=dynamic --with-http_geoip_module=dynamic --with-http_perl_module=dynamic --with-threads --with-stream --with-stream_ssl_module --with-stream_geoip_module=dynamic --with-http_slice_module --with-mail --with-mail_ssl_module --with-file-aio --with-ipv6 --with-http_v2_module --with-cc-opt='-g -O2 -fstack-protector-strong -Wformat -Werror=format-security -Wp,-D_FORTIFY_SOURCE=2' --with-ld-opt='-Wl,-z,relro -Wl,--as-needed' --add-module=/etc/nginx/kompiler/echo-nginx-module-master --add-module=/etc/nginx/kompiler/nchan-master --add-module=/etc/nginx/kompiler/nginx-rtmp-module-master --add-module=/etc/nginx/kompiler/nginx-upload-progress-module-master
			
			echo "${loc_install_pak}"
			make && make install
		fi
		checknginxstatus=1
}

if [ "${dist}" = "debian" ] || [ "${dist}" = "ubuntu" ]; then
	if [ "$(dpkg -l | grep nginx)" ]; then
		nginx_modules_install
	else
		echo "${loc_no_install_nginx}";
		echo "${loc_install_last_v_nginx}"
		echo "1) ${loc_yes}"
		echo "2) ${loc_no}"
		read -p "${loc_choose}: " install_last_ver_nginx
		if [ $install_last_ver_nginx -eq 1 ]; then
			if [ -z "$(dpkg -l | grep ca-certificates)" ]; then
				apt-get install -y ca-certificates
			fi
			echo "${loc_go_to_dir}"
			cd
			
			echo "${loc_mkdir_dir}"
			mkdir nginx-install-auto 
			
			echo "${loc_go_to_dir} nginx-install-auto"
			cd nginx-install-auto
			
			echo "${loc_down_nginx_install_auto}"
			wget https://github.com/alexeymalets/nginx-install-auto/archive/master.zip
			
			echo "${loc_install_pak}"
			unzip master.zip
			
			echo "${loc_go_to_dir} nginx-install-auto-master"
			cd nginx-install-auto-master && chmod 777 nginx_install.sh
			
			echo "${loc_run_script}"
			sh nginx_install.sh
			
			nginx_modules_install
		fi
	fi
fi

if [ $checknginxstatus -eq 1 ]; then
	echo "${loc_restart_nginx}"
	if [ "${dist}" = "debian" ] && [ "${osv}" = "8" ] || [ "${dist}" = "ubuntu" ] && [ "${osv}" = "xenial" ] ; then
		systemctl restart nginx
		echo "${loc_status_nginx}"
		if [ -z "$(systemctl status nginx | grep "inactive")" ] && [ -z "$(systemctl status nginx | grep "failed")" ]; then
			echo "${loc_upgrade_nginx_sf}!"		
		else
			echo "${loc_upgrade_nginx_faild}"
			echo "GitHub https://github.com/alexeymalets/nginx-install-auto/issues"
			echo "${loc_srv_admin} http://svradmin.ru/"
			echo "${loc_myhosti}(24/7) https://myhosti.pro"
			echo "${loc_error} :$(systemctl status nginx.service)"
		fi
	else
		service nginx restart
		echo "${loc_status_nginx}"
		if [ -z "$(service nginx status | grep stopped)" ] && [ -z "$(service nginx status | grep failed)" ]; then
			echo "${loc_upgrade_nginx_sf}!"		
		else
			echo "${loc_upgrade_nginx_faild}"
			echo "GitHub https://github.com/alexeymalets/nginx-install-auto/issues"
			echo "${loc_srv_admin} http://svradmin.ru/"
			echo "${loc_myhosti}(24/7) https://myhosti.pro"
			echo "${loc_error} :$(tail -n 10 /var/log/nginx/error.log)"
		fi
	fi
fi

echo "${loc_thanks_soft}"