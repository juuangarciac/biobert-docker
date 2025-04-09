# Dockerfile builds an image of biobert pretrained model, for fine-turning into QA
FROM tensorflow/tensorflow:1.15.5-gpu-py3

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A4B469963BF863CC

RUN apt-get update -y && apt-get install -y python3-dev build-essential wget

RUN apt install emacs

COPY . /app

WORKDIR /app

RUN wget https://github.com/naver/biobert-pretrained/releases/download/v1.1-pubmed/biobert_v1.1_pubmed.tar.gz

RUN tar -zxvf ./biobert_v1.1_pubmed.tar.gz

RUN pip install -r requirements.txt

ENV BIOBERT_DATA=./datasets

ENV BIOBERT_DIR=./biobert_v1.1_pubmed

ENV QA_DIR=./datasets/QA/BioASQ

ENV OUTPUT_DIR=OUTPUT_DIR=./qa_outputs

RUN mkdir -p $OUTPUT_DIR