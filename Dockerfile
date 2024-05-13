FROM python:slim AS builder
COPY requirements.txt .
RUN apt-get update && \
    apt-get install -y libmariadb-dev libmariadb3 gcc && \
    pip install --prefix=/temp -r requirements.txt 

FROM python:slim
RUN apt-get update && \ 
    apt-get install -y libmariadb-dev
COPY app.py databasefunctions.py secrets.py /app/
COPY /templates   /app/templates
COPY /statis   /app/static
COPY --from=builder /temp /usr/local

WORKDIR /app

