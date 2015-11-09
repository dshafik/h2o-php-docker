FROM ubuntu:15.10
MAINTAINER Davey Shafik <dshafik@akamai.com>
RUN apt-get update -qq
RUN apt-get install --yes build-essential cmake git
RUN apt-get install --yes zlib1g-dev 
RUN apt-get install --yes daemontools
RUN apt-get install --yes php5-fpm 
RUN git clone https://github.com/h2o/h2o.git 
WORKDIR h2o
RUN cmake .
RUN make
RUN make install
WORKDIR ../
COPY config/* ./
COPY config/www.conf /etc/php5/fpm/pool.d/www.conf
RUN mkdir -p app/public && echo "<h1>It works!</h1>" > app/public/index.html

VOLUME /app 

CMD service php5-fpm start &&  /usr/local/bin/h2o -c h2o.conf
EXPOSE 80 443 
