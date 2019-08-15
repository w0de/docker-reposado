docker-reposado
===============

Docker container to run reposado and serve softwareupdates using nginx

sample usage.

```
 docker run --rm -i -t macadmins/reposado python /reposado/code/repoutil --help
 ```
 To have persistent storage, use a volume container. Example:
 ```
 docker run --rm -i -t --volumes-from reposado-data macadmins/reposado python /reposado/code/repo_sync
 ```
 You can also mount external, previously used cache:
 ```
 --mount type=bind,source=/data/reposado,target=/reposado/html
 ```

You can schedule the above command via cron/systemd or run it manually.

##Note
Currently, the port *has* to be 8080 for both the container and the host. The LocalCatalogBaseURL is http://reposado:8080

#Margarita
[Margarita](https://github.com/w0de/margarita) (saml-enabled-fork) is also bundled in but not enabled by default.
You can run the Margarita Flask server either together with nginx, by opening both -p 8080 and -p 8089 or separately like so:
```
/usr/bin/docker run --rm --name margarita   --mount type=bind,source=/data/reposado,target=/reposado/html --mount type=bind,source=/data/saml,target=/home/app/saml --volumes-from reposado-data -p 8089:8089 w0de/reposado SAML_AUTH_ENABLED=False SAML_PATH=/home/app/saml python /home/app/margarita/run.py
```

#Margarita SAML

```
/usr/bin/docker run --rm --name margarita -p 80:8080 -p 443:443 -p 8089:8089 w0de/reposado SAML_AUTH=True SAML python /home/app/margarita/run.py runserver
```


#TODO
* passenger_wsgi script for margarita
* nginx configuration file for margarita
* move reposado.conf and margarita.conf to sites-available and symlink to sites-enabled as needed
* basic authentication for margarita
* allow using a different LocalCatalogBaseURL (suggestions welcome)
