FROM ubuntu:18.04

ENV DEBIAN_FRONTEND="noninteractive"

RUN apt-get update
RUN apt-get install -y curl ca-certificates gnupg

RUN curl https://www.postgresql.org/media/keys/ACCC4CF8.asc | gpg --dearmor | tee /etc/apt/trusted.gpg.d/apt.postgresql.org.gpg
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ bionic-pgdg main" > /etc/apt/sources.list.d/pgdg.list

RUN apt-get update
RUN apt-get install -y build-essential libsnappy-dev postgresql-common devscripts

RUN sed -i "s/^#start_conf.*/start_conf='manual'/g" /etc/postgresql-common/createcluster.conf
RUN sed -i "s/^#create_main_cluster.*/create_main_cluster=false/g" /etc/postgresql-common/createcluster.conf

RUN apt-get install -y python3.6 python3.6-dev python3.6-venv

RUN apt-get install -y postgresql-10 postgresql-11 postgresql-12 postgresql-13 postgresql-14 postgresql-server-dev-10 postgresql-server-dev-11 postgresql-server-dev-12 postgresql-server-dev-13 postgresql-server-dev-14

RUN apt-get install -y debhelper dh-python python3-all python3-cryptography python3-dateutil python3-flake8 python3-psycopg2 python3-pytest python3-paramiko python3-setuptools python3-snappy pylint3 python3-pip python3-protobuf

RUN mkdir -p /src/pghoard

COPY . /src/pghoard/

WORKDIR /src/pghoard

RUN pip3 install protobuf==3.19.4 rohmu==1.0.4

ENV DEB_BUILD_OPTIONS=nocheck

CMD ["make","deb"]