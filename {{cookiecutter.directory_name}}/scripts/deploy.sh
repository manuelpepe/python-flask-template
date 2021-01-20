#!/bin/bash -e
echo -n ">> Enter secret key: "
read KEY

echo "[I] Copying {{cookiecutter.app_name}}.service file to /etc/systemd/system"
sed -e "s/FLASK_SECRET_KEY=YOURKEYHERE/FLASK_SECRET_KEY=$KEY/g" {{cookiecutter.app_name}}.service > /etc/systemd/system/

echo "[I] Starting service"
sudo systemctl start {{cookiecutter.app_name}}

echo "[I] Enabling service"
sudo systemctl enable {{cookiecutter.app_name}}

echo "[I] Service Status:"
sudo systemctl status {{cookiecutter.app_name}}

echo -n "Continue? "
read -s cont
if [[ "$cont" != "y" || "$cont" != "Y" ]];
	echo "[I] Stopping deploy."
	exit 1
fi

echo "[I] Copying {{cookiecutter.app_name}}.nginx-site file to /etc/nginx/sites-available/{{cookiecutter.app_name}}"
cp {{cookiecutter.app_name}}.nginx-site /etc/nginx/sites-available/{{cookiecutter.app_name}}

echo "[I] Creating symlink from sites-available to sites-enabled"
ln -s /etc/nginx/sites-available/{{cookiecutter.app_name}} /etc/nginx/sites-enabled

echo "[I] Running syntax check "
sudo nginx -t  # Check syntax
if [[ "$?" != 0 ]]; then
	echo "[ERROR] Syntax error on nginx. Removing /etc/nginx/sites-enabled/{{cookiecutter.app_name}}."
	echo "Check {{cookiecutter.app_name}}.nginx-site and try again."
	rm /etc/nginx/sites-enabled/{{cookiecutter.app_name}}
	exit 2
fi

echo "[I] Restarting nginx "
sudo systemctl restart nginx  # Apply changes

echo "[I] Deploy completed"