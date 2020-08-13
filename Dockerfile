FROM ubuntu

WORKDIR /build

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
 && apt-get install -y git g++ emacs r-base nano wget

RUN cd /build \
 && mkdir fftw3 \
 && cd fftw3 \
 && wget http://www.fftw.org/fftw-3.3.8.tar.gz \
 && tar -xzvf fftw-3.3.8.tar.gz \
 && cd fftw-3.3.8 \
 && ./configure --prefix=/build/fftw3 --enable-shared \
 && make && make install

RUN mkdir /data \
 && mkdir /data1 \
 && mkdir /data2 \
 && mkdir /tutorial \
 && cd /tutorial \
 && wget http://zzz.bwh.harvard.edu/dist/luna/tutorial.zip \
 && unzip tutorial.zip \
 && rm tutorial.zip \
 && ln -s /data/ data

RUN  R -e "install.packages('plotrix', repos='http://cran.rstudio.com/')" \
 && R -e "install.packages('geosphere', repos='http://cran.rstudio.com/')"
