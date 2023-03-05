FROM python:3.10-alpine3.17
LABEL maintainer="github.com/suyious"

ENV PYTHONUNBUFFERED 1

COPY ./requirements.txt /tmp/requirements.txt
COPY ./requirements.dev.txt /tmp/requirements.dev.txt
copy ./src /src
WORKDIR /src
EXPOSE 8000

ARG DEV=false
RUN python -m venv /py \
	&& /py/bin/pip install --upgrade pip \
	&& if [ $DEV = true ]; \
		then /py/bin/pip install -r /tmp/requirements.dev.txt; \
		else /py/bin/pip install -r /tmp/requirements.txt; \
	fi \
	&& rm -rf /tmp \
	&& adduser --disabled-password --no-create-home django-user

ENV PATH="/py/bin:$PATH"
USER django-user
