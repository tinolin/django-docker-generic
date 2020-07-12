# Django-generic APP on Docker
![Python 3.5|3.6](https://img.shields.io/badge/Python-3.6%2F3.7-blue.svg)

> Deploy simple django base app with docker.

### Prerequisites

- [Docker](https://www.docker.com/get-started), is a tool designed to make it easier to create, deploy, and run applications by using containers.
- [Django](https://www.djangoproject.com/), a high-level [Python](https://www.python.org/) Web framework.
- [VirtualEnv](https://virtualenv.pypa.io/en/latest/) a tool to create isolated Python environments, to have [Django](https://www.djangoproject.com/) commands available.

## Repository structure
* The folder `django-docker-generic` contains two very important files, a [Dockerfile](https://raw.githubusercontent.com/tinolin/django-docker-generic/master/Dockerfile) to run docker-command build and the [.dockerignore](https://raw.githubusercontent.com/tinolin/django-docker-generic/master/.dockerignore) file that contains a ignore regex patern to deploy django project on Docker securely.

## TL;DR;

Download the files [Dockerfile](https://raw.githubusercontent.com/tinolin/django-docker-generic/master/Dockerfile) and [.dockerignore](https://raw.githubusercontent.com/tinolin/django-docker-generic/master/.dockerignore); Run the `build` of the image with the Docker commands, inside of you django-proyect folder. Here are some examples:

```console
# my-django-project-folder/ #: docker build --build-arg PROJECT_NAME=my-django-project-folder -t my-image-name .

# my-django-project-folder/ #: docker run --rm -it -p 80:8000 -e PROJECT_NAME=my-django-project-folder my-image-name:latest

```

Then access from you web-browser to 0.0.0.0:80

## Changelog

### 0.2

* Modified the [Dockerfile](https://raw.githubusercontent.com/tinolin/django-docker-generic/master/Dockerfile).
* * Add build argument to plan projet folder structure on build.
* * Change order from commands to optimize builds after adding argument.
* Modified the  [.dockerignore](https://raw.githubusercontent.com/tinolin/django-docker-generic/master/.dockerignore).
* * Adjust ignore files and folder.  

### 0.1

* Added simple [Dockerfile](https://raw.githubusercontent.com/tinolin/django-docker-generic/master/Dockerfile).
* Added simple [.dockerignore](https://raw.githubusercontent.com/tinolin/django-docker-generic/master/.dockerignore).

## Remarks

### Enviroment Variables Availables

- PROJECT_NAME: name of the Django-proyect to load project settings (mandatory).
- HOST: net address to bind Gunicorn to serve the app (def 0.0.0.0).
- PORT: network port to bind Gunicorn to serve the app (def 80).
- WORKERS: Gunicorn procesess for better performance(def 3). 
- USER: django user to login (def admin).
- PSWD: django pass to login (def admin).


### Python Essential tools used:

- [Gunicorn](https://gunicorn.org/): Python WSGI HTTP Server for UNIX.
- [Whitenoise](http://whitenoise.evans.io/en/stable/): Radically simplified static file serving for Python web apps. 


#

> Please let me know if it works.
