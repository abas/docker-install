FROM node:8

LABEL kankuu <akhmadbasir5@gmail.com>

RUN echo "|----> updating repository" \
  && apt-get update -y \
  && echo "|----> successfull update" \
  || echo "|----> failed to update"

RUN echo "|----> installing tool" \
  && apt-get install -y \
  # add tool here
  nano \
  && echo "|----> successfull installing tool" \
  || echo "|----> failed to install tool"

RUN mkdir /app
WORKDIR /app

EXPOSE 3000