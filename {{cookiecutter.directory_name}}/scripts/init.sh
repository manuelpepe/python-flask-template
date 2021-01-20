#!/bin/bash -e
user=$1
if [[ -z "$user" ]]; then
	user="www-data:www-data"
fi

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [[ ! -d /etc/{{cookiecutter.app_name}} ]]; then
	mkdir /etc/{{cookiecutter.app_name}}
fi

if [[ ! -f /etc/{{cookiecutter.app_name}}/config.toml ]]; then
	cat $DIR/../resources/config.toml > /etc/{{cookiecutter.app_name}}/config.toml
fi

chown -R "$user" /etc/{{cookiecutter.app_name}}

echo "Initialized"