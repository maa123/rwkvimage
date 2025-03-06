#Python 3.10
FROM python:3.13-slim as build

WORKDIR /app

RUN apt-get update && apt-get install -y git cmake build-essential && rm -rf /var/lib/apt/lists/*

RUN git clone --recursive https://github.com/saharNooby/rwkv.cpp.git --depth 1 . && rm -rf .git

RUN cmake . && cmake --build . --config Release && mkdir src && cp librwkv.so src/

COPY requirements.txt .

RUN pip install -r requirements.txt --user --no-cache-dir

#Multi-stage build

FROM python:3.13-slim as base

WORKDIR /app

COPY --from=build /root/.local /root/.local
COPY --from=build /app/src /app
