FROM python:3.7-slim
MAINTAINER tinolin2010@gmail.com

WORKDIR /usr/src/app

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    LC_ALL=C.UTF-8 \
    HOST=0.0.0.0 \
    PORT=80 \
    WORKERS=3 \
    USER=admin \
    PSWD=admin

COPY requirements.txt /usr/src/app

RUN pip install --upgrade pip && \
    pip install django gunicorn whitenoise && \
    pip install --no-cache-dir -r requirements.txt

ADD . /usr/src/app

RUN python manage.py makemigrations --noinput && \
    python manage.py migrate --noinput

RUN find . -name "settings.py" -exec sed -i \
    "/django.middleware.clickjacking.XFrameOptionsMiddleware/ i \
    \ \  \ 'whitenoise.middleware.WhiteNoiseMiddleware'\," {} +

RUN echo "from django.contrib.auth.models import User;\
    User.objects.create_superuser('${USER}', '', '${PSWD}')"\
    | python manage.py shell

EXPOSE ${PORT}

ARG PROJECT_NAME
RUN if [ -z "${PROJECT_NAME}" ]; then echo "NOT SET - ERROR"; exit 1; else : ; fi
ENV PROJECT_NAME=${PROJECT_NAME}

CMD exec gunicorn ${PROJECT_NAME}.wsgi:application --bind ${HOST}:${PORT} --workers ${WORKERS}
