docker-reposado
===============

## About

This container and associated instructions assume you'd like margarita run. Consider upstream if margarita is not important to you.

Additionally, repo_sync runs on every boot.

## Margarita SAML

This uses my fork of margarita, which is SAML-enabled. To configure, see instructions at [Margarita](https://github.com/w0de/margarita) - mount your SAML configuration directory to `/home/app/saml`. You may skip SAML by simply not passing SAML_AUTH_ENABLED environment variable.


This container runs margarita with the inbuilt python webserver, since usage is expected to be low. Nginx provides reposado.

## Usage
This container expects the operator to mount a volume on the host to contain the cached Apple updates. It should be mounted to `/reposado/html`. It is also recommended to preserve your metadata (catalogs, etc) by mounting a directory to `/reposado/metadata`. To u

This is an example command will start reposado/margarita all features enabled:

```
/usr/bin/docker run --rm --name margarita --mount type=bind,source=/data/reposado,target=/reposado/html --mount type=bind,source=/data/metadata,target=/reposado/metadata -p 80:80 -p 443:443 -p 8089:8089 -e SAML_AUTH_ENABLED=True w0de/reposado
```

#TODO
* wsgi for margarita?
* basic authentication for margarita - done!
* allow using a different LocalCatalogBaseURL (suggestions welcome)
