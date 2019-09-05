FROM python:3.7-slim
MAINTAINER your_name

ADD . /usr/src/app
COPY requirements.txt ./

WORKDIR /usr/src/app

ENV PROJECT_NAME=your_project_name \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    LC_ALL=C.UTF-8 \
    HOST=0.0.0.0 \
    PORT=8000 \
    WORKERS=3 \
    USER=admin \
    PSWD=admin

RUN pip install --upgrade pip && \
    pip install django gunicorn whitenoise && \
    pip install --no-cache-dir -r requirements.txt


RUN python manage.py makemigrations --noinput && \
    python manage.py migrate --noinput

RUN find . -name "settings.py" -exec sed -i \
    "/django.middleware.clickjacking.XFrameOptionsMiddleware/ i \
    \ \  \ 'whitenoise.middleware.WhiteNoiseMiddleware'\," {} +

RUN echo "from django.contrib.auth.models import User;\
    User.objects.create_superuser('${USER}', '', '${PSWD}')"\
    | python manage.py shell

EXPOSE ${PORT}

CMD exec gunicorn ${PROJECT_NAME}.wsgi:application --bind ${HOST}:${PORT} --workers ${WORKERS}
