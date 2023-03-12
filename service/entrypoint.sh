#!/bin/sh

if [ "$DB" = "mysql" ]

then
    echo "Ожидание службы mysql..."

    while ! nc -z $DB_HOST $DB_POST; do
      sleep 0.1
    done

    echo "Сервис mysql запущен"
fi

python manage.py makemigrations
python manage.py migrate
python manage.py collectstatic --noinput --clear
gunicorn backend.wsgi:application --bind 0.0.0.0:8000

exec "$@"