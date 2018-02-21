

# edeliver <img src="http://boldpoker.net/images/edeliver_500.png" width=120> 

## Vorbereitung

### Auf dem Server

Environment Variable `PORT` im Terminal setzten.

```bash
# 8888 8889 8890
export MYAPP_PORT=8888
# Überprüfen echo $MYAPP_PORT
```
In **centos**
```bash
nano ~\.bashrc
```
Folgende Änderung:
```bash
export PATH="$PATH:/usr/local/elixir/bin"
# geändert zu
export PATH="$PATH:/usr/bin/elixir/bin"
```
Evtl. auch ??

```bash
nano ~\.profile
# hinzugefügt
export PATH="$PATH:/usr/bin/elixir/bin"
```

Die Datei `\config\prod.secret.exs` auf den Server unter
`\home\USER\builder\MyApp\prod.secret.exs` kopieren.
Danach in `.gitignore` ergänzen
```bash
# edeliver
/config/prod.secret.exs
.deliver/releases/
```


In der config `\config\prod.exs` den Inhalt zu folgendem ändern:

```elixir
url: [host: "MY_SERVER_IP", port: {:system, "MYAPP_PORT"}],
server: true,
version: Mix.Project.config[:version],
```
In der Datei `mix.exs` folgendes ändern:
```elixir
# extra_application Add edeliver to the END of the list
:edeliver
# In deps einfügen
{:distillery, "~> 1.5", warn_missing: false},
{:edeliver, "~> 1.4"}
```
Dann `mix deps.get` ausführen.

#### nginx
Konfiguration aufrufen
```bash
sudo nano /etc/nginx/nginx.conf
```

```bash
upstream edwin {
    ip_hash;
    server 127.0.0.1:8889;
}
map $http_upgrade $connection_upgrade {
     default upgrade;
     '' close;
}
server {
    listen       80;
    listen       [::]:80;
    server_name  edwin.esta4.com;
    include /etc/nginx/default.d/*.conf;
    location / {
       	try_files $uri @proxy;
    }
    location @proxy {
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for; #
        proxy_set_header  Host $host;
        proxy_http_version 1.1;
        proxy_redirect off;
        proxy_pass http://edwin;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection $connection_upgrade;
    }
    error_page 404 /404.html;
    location = /40x.html {
    }
    error_page 500 502 503 504 /50x.html;
 	    location = /50x.html {
    }
}
```

**nginx** Neustart
```bash
sudo service nginx restart
```
### distillery

To initialize Distillery, just run

```bash
mix release.init
```

### edeliver

Im Projekt die Datei `.deliver/config` erzeugen.
Mit folgendem Inhalt:

```bash
# .deliver/config

APP="myapp_app" # name of your release

BUILD_HOST="85.214.128.188" # host where to build the release
BUILD_USER="edwin" # local user at build host
BUILD_AT="/home/edwin/tmp/edeliver/$APP/builds" # build directory on build host


RELEASE_DIR="/home/edwin/tmp/edeliver/builds/_build/prod/rel/$APP"

# prevent re-installing node modules; this defaults to "."
GIT_CLEAN_PATHS="_build rel priv/static"

USING_DISTILLERY="true"

STAGING_HOSTS="85.214.128.188"  # staging / test hosts separated by space
STAGING_USER="edwin" # local user at staging hosts
TEST_AT="/home/edwin/deploy/staging/$APP" # deploy directory on staging hosts. default is DELIVER_TO

PRODUCTION_HOSTS="85.214.128.188" # deploy / production hosts separated by space
PRODUCTION_USER="edwin" # local user at deploy hosts
DELIVER_TO="/home/edwin/deploy/production" # deploy directory on production hosts

# For *Phoenix* projects, symlink prod.secret.exs to our tmp source
pre_erlang_get_and_update_deps() {
  local _prod_secret_path="/home/edwin/builder/$APP/prod.secret.exs"
  if [ "$TARGET_MIX_ENV" = "prod" ]; then
    __sync_remote "
      ln -sfn '$_prod_secret_path' '$BUILD_AT/config/prod.secret.exs'
    "
  fi
}
```

Alles mit `Git` zum master branch committen.

```bash
mix edeliver build release
```

Zum testen Release to Staging.
```bash
mix edeliver deploy release
```

Build a release and deploy it to your production hosts:
```bash
mix edeliver build release --branch=master
mix edeliver deploy release to production
mix edeliver start production
```

mix edeliver ping production
mix edeliver restart production

