FROM python:2.7

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY . /usr/src/app
RUN apt-get update
RUN apt-get install sudo
RUN cd /usr/src/app && pip install --no-cache-dir -r requirements.txt uwsgi
RUN adduser --disabled-password --gecos '' uwsgiuser

VOLUME ["/usr/src/app"]

CMD ["sh", "run_uwsgi.sh"]
