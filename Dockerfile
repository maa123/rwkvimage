#Python 3.10
FROM python:3.10-slim as build

WORKDIR /app

RUN apt-get update && apt-get install -y git

COPY requirements.txt .

RUN pip install -r requirements.txt --user

COPY rwkv-git/ RWKV/.git/

RUN cd RWKV && git pull origin main && cd /app && mv RWKV/RWKV-v4neo/src /app/src && rm -rf RWKV

#Multi-stage build

FROM python:3.10-slim as base

WORKDIR /app

COPY --from=build /root/.local /root/.local
COPY --from=build /app/src /app/src
