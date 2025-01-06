#FROM python:3-alpine
FROM image-registry.openshift-image-registry.svc:5000/pipeline-tutorial/nitish/nitish:latest
#FROM alpine:latest
#RUN apk add --no-cache python3 py3-pip \
#    && pip3 install --upgrade pip

WORKDIR /app
COPY . /app

RUN pip3 --no-cache-dir install -r requirements.txt

EXPOSE 5000

ENTRYPOINT ["python3"]
CMD ["helloworld.py"]
