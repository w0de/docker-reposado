# Use phusion/passenger-full as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/passenger-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/passenger-full:1.0.6

# Set correct environment variables.
ENV HOME /root
ENV LOCALCATALOGURLBASE http://reposado
ENV SAML_PATH /home/app/saml

RUN apt-get update && apt-get install -y \
  python-pip \
  python-dev \
  python3 \
  curl \
  libxmlsec1-dev \
  git

RUN git clone https://github.com/wdas/reposado.git /reposado
ADD preferences.plist /reposado/code/
ADD write_config.py /
RUN chmod +x /write_config.py
ADD sync_and_clean.sh /
RUN chmod +x /sync_and_clean.sh
RUN pip install simplejson

RUN git clone https://github.com/w0de/margarita.git /home/app/margarita
RUN ln -s /reposado/code/reposadolib /home/app/margarita
RUN ln -s /reposado/code/preferences.plist /home/app/margarita
RUN ln -s /reposado/code/preferences.plist /usr/share/passenger/helper-scripts/
RUN pip install -r /home/app/margarita/requirements.txt
ADD reposado.conf /etc/nginx/sites-enabled/reposado.conf
ADD margarita.conf /etc/nginx/sites-enabled/margarita.conf
ADD passenger_wsgi.py /home/app/margarita/passenger_wsgi.py
RUN mkdir -p /home/app/margarita/public
RUN chown -R app:app /home/app/margarita

VOLUME /reposado/code
EXPOSE 80
EXPOSE 8089

RUN rm -f /etc/nginx/sites-enabled/default
RUN rm -f /etc/service/nginx/down
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ADD start.sh /start.sh
CMD ["/bin/bash", "/start.sh"]
