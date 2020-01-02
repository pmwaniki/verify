FROM python:3.7
ENV PYTHONBUFFERED 1
RUN mkdir /code
RUN mkdir -p /verify-app/media
RUN mkdir -p /verify-app/static

WORKDIR /code
COPY requirements.txt /code/
RUN apt-get update \
    && apt-get install python3-dev default-libmysqlclient-dev  -y \
    && pip install --upgrade pip && pip install -r requirements.txt
#COPY . /code/

EXPOSE 8000
