FROM python:3.12.0b1-slim-bullseye AS base

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

ENTRYPOINT [ "sh" ]

CMD [ "entrypoint.sh" ]