FROM ubuntu:16.04
RUN apt-get update
RUN apt-get install wget -y

RUN apt-get install -y build-essential

RUN apt install libssl-dev zlib1g-dev libncurses5-dev libncursesw5-dev libreadline-dev libsqlite3-dev -y
RUN apt install libgdbm-dev libdb5.3-dev libbz2-dev libexpat1-dev liblzma-dev libffi-dev uuid-dev -y
RUN apt-get install -y cmake 
RUN apt-get install -y python3-pip

RUN wget https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tgz
# RUN  apt-get install python3.7 -y
RUN tar -xf Python-3.7.0.tgz
RUN cd Python-3.7.0 && ./configure --enable-optimizations && make -j 8 && make altinstall
# apt install python3.7
RUN apt-get install -y python3-virtualenv

COPY . /
WORKDIR /

RUN python3.7 -m venv mario

# RUN python3.7 virtualenv -p --python=python3.7.0 mario
RUN /bin/bash -c "source mario/bin/activate"
RUN pip3 install pip --upgrade;
# ADD $PWD/requirements.txt /requirement.txt
RUN pip3 install -r ./requirement.txt
EXPOSE 5001
CMD ["python3.7", "server.py"]
