# Use phusion/passenger-full as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/passenger-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM nginx:mainline

# Set correct environment variables.
ENV HOME /root
ENV LOCALCATALOGURLBASE http://reposado
ENV SAML_PATH /home/app/saml

RUN apt-get update && apt-get install -y \
  python-pip \
  python-dev \
  curl \
  libxmlsec1-dev \
  git

RUN git clone https://github.com/wdas/reposado.git /reposado
ADD preferences.plist /reposado/code/
ADD reposado.conf /etc/nginx/sites-enabled/reposado.conf
RUN pip install simplejson
RUN git clone https://github.com/w0de/margarita.git /home/app/margarita
RUN ln -s /reposado/code/reposadolib /home/app/margarita
RUN ln -s /reposado/code/preferences.plist /home/app/margarita
RUN pip install -r /home/app/margarita/requirements.txt

VOLUME /reposado/code
EXPOSE 80

RUN rm -f /etc/nginx/sites-enabled/default
RUN rm -f /etc/service/nginx/down
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD start.sh /start.sh
CMD ["/bin/bash", "/start.sh"]
