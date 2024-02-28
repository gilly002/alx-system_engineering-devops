#!/usr/bin/env bash
# Settingup New Ubuntu server with nginx

exec { 'updating the system':
        command => '/usr/bin/apt-get update',
}

file {'/var/www/html/index.html':
	content => 'Hello World!'
}

package { 'nginx':
	ensure => 'installed',
	require => Exec['update system']
}

service {'nginx':
	ensure => running,
	require => Package['nginx']
}

exec {'redirect_me':
	command => 'sed -i "24i\	rewrite ^/redirect_me https://www.youtube.com/watch?v=QH2-TGUlwu4 permanent;" /etc/nginx/sites-available/default',
	provider => 'shell'
}
