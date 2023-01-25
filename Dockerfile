FROM ubuntu:latest

RUN apt-get update && apt-get install -y apache2

RUN echo "<html><body><h1>Hello From Pankaj in Docker Container</h1></body></html>" > /var/www/html/index.html

EXPOSE 80

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]



# FROM ubuntu 
# RUN apt-get update 
# RUN apt-get install –y apache2 
# RUN apt-get install –y apache2-utils 
# RUN apt-get clean 
# EXPOSE 80 
# CMD [“apache2ctl”, “-D”, “FOREGROUND”]


# FROM  centos:latest
# MAINTAINER vikashashoke@gmail.com
# RUN yum install -y httpd \
#  zip\
#  unzip
# ADD https://www.free-css.com/assets/files/free-css-templates/download/page254/photogenic.zip /var/www/html/
# WORKDIR /var/www/html/
# RUN unzip photogenic.zip
# RUN cp -rvf photogenic/* .
# RUN rm -rf photogenic photogenic.zip
# CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
# EXPOSE 80 443 22


# FROM  centos:latest
# MAINTAINER vikashashoke@gmail.com
# RUN yum install -y httpd \
#  zip\
#  unzip
#  ADD https://www.free-css.com/assets/files/free-css-templates/download/page265/shine.zip /var/www/html/
#  WORKDIR /var/www/html/
#  RUN unzip shine.zip
#  RUN cp -rvf shine/* .
#  RUN rm -rf shine shine.zip
#  CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
#  EXPOSE 80
