FROM tensorflow/tensorflow:1.15.5-gpu-py3

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A4B469963BF863CC

RUN apt-get update -y && apt-get install -y python3-dev build-essential wget

COPY . /app

WORKDIR /app

RUN wget https://github.com/naver/biobert-pretrained/releases/download/v1.1-pubmed/biobert_v1.1_pubmed.tar.gz

RUN tar -zxvf ./biobert_v1.1_pubmed.tar.gz

RUN pip install -r requirements.txt

RUN sed -i -e 's/\r$//' ./download.sh

RUN ./download.sh

ENV BIOBERT_DIR=./biobert_v1.1_pubmed

ENV RE_DIR=./datasets/RE/GAD/1

ENV NER_DIR=./datasets/NER/NCBI-disease

ENV TASK_NAME=gad

ENV OUTPUT_DIR=./re_outputs_1

RUN mkdir -p $OUTPUT_DIR