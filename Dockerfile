FROM ubuntu:17.10

LABEL maintainer="kyledevinobrien1@gmail.com"

# Install Python
RUN apt-get update
RUN apt-get install sudo curl -y
RUN sudo apt-get install python3-pip python3-dev -y
RUN curl https://bootstrap.pypa.io/get-pip.py | sudo python3.6
RUN sudo pip install --upgrade pip

# Reqs file is copied first to installs are cached.
COPY ./requirements.txt ./ocr-api/requirements.txt
RUN pip3 install -r ./ocr-api/requirements.txt

COPY . ./ocr-api

WORKDIR ./ocr-api

EXPOSE 4000

# Downloads MNIST Data Set
RUN python3.6 download.py

CMD ["python3", "app.py"]
