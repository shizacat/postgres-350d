FROM postgres:10.6
MAINTAINER Matveev Alexey

ARG	A_DIMENSHION=128

# ===/ Dimenshion cube
RUN apt-get update && \
	apt-get install -y build-essential curl postgresql-server-dev-10 && \
	curl https://ftp.postgresql.org/pub/source/v10.6/postgresql-10.6.tar.bz2 -o /postgresql-10.6.tar.bz2 && \
	tar xvf /postgresql-10.6.tar.bz2 && \
	cd /postgresql-10.6/contrib/cube && \
	sed -i "s/#define CUBE_MAX_DIM (100)/#define CUBE_MAX_DIM (${A_DIMENSHION}/" cubedata.h && \
    USE_PGXS=true make && \
    USE_PGXS=true make install && \
    rm -rf /postgresql-10.6 && \
    apt-get remove -y build-essential curl postgresql-server-dev-10 && \
	apt-get -y autoremove && \
	rm -rf /var/lib/apt/lists/*

EXPOSE 5432