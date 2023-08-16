#Python 3.10
FROM python:3.10-slim as base

WORKDIR /app

RUN apt-get update && apt-get install -y git

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY rwkv-git/ RWKV/.git/

RUN cd RWKV && git pull origin main && cd /app && mv RWKV/RWKV-v4neo/src /app/src && rm -rf RWKV
