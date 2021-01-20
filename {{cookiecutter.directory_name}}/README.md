# {{cookiecutter.project_name}}

{{cookiecutter.description}}


## Installation

Clone the repo and run `./scripts/init.sh` to initialize the configuration.

```bash
	$ git clone {{cookiecutter.project_url}} /var/www/{{cookiecutter.app_name}}
	$ python3.7 -m venv venv
	$ source venv/bin/activate
	$ pip install -r requirements.txt -r requirements-dev.txt
	$ sudo ./scripts/init.sh $USER
	$ export FLASK_APP={{cookiecutter.app_name}}
	$ flask run --host=0.0.0.0
```


## Developing

After cloning the repo and installing all dependencies, make sure to install the pre-commit hooks for the
automatic formatter (see black):

```bash
	$ source venv/bin/activate
	$ pip install -r requirements-dev.txt
	$ pre-commit install
```

### Running tests

To run the tests you need a local MySQL installation. You should be able to just run `pytest` after running the 
`resources/test_db.sql` script in your MySQL installation.


## Configuration

The flask app configuration can be changed in the file `/etc/{{cookiecutter.app_name}}/config.toml`.


## Deploy

### Deployment with with nginx and uwsgi.
	
1. Clone the project to your www:
	
```bash
	$ git clone {{cookiecutter.project_url}} /var/www/{{cookiecutter.app_name}}
	$ chown -R www-data: /var/www/{{cookiecutter.app_name}}
```

2. Initialize and deploy:

```bash
	$ python3.7 -m venv venv
	$ source venv/bin/activate
	$ pip install -r requirements.txt
	$ ./scripts/init.sh
	$ ./scripts/deploy.sh  # Interactive deploy
```

Usefull logs:

```bash
	$ less /var/log/nginx/error.log: Nginx error logs.
	$ less /var/log/nginx/access.log: Nginx access logs.
	$ journalctl -u nginx: Nginx process logs.
	$ journalctl -u {{cookiecutter.app_name}}: uWSGI logs from dashboard.
```
