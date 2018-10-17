# XDEBUG
### PHPStorm
##### Adding Server
First we need to define our server for debugging.
* File -> Settings -> Languages & Frameworks -> PHP -> Servers
* Click `+` button on the top left
* Give it a name, name is very important! It has to match the value in `.env` file (more on the that later)
* Host: `host.docker.internal` as this is the right way for newer Docker versions. 
See [this](https://docs.docker.com/docker-for-mac/networking/#use-cases-and-workarounds) for more info on the 
subject
* Leave port at `80` (don't worry even 443 will connect)
* Leave Debugger as `XDebug`
* Click & enable "Use Mappings" option
* Now in Project Files, map your host files (local computer) to absolute path on server. When you click on the empty
side, it will allow you to write the path. So the path would be `/var/www` on the docker container.

Now in your `docker-compose.yml` file you probably have an `env_file: .env` option for php-fpm (and / or cli).

Make sure you have following settings in there;

```
XDEBUG_CONFIG=remote_host="host.docker.internal"
PHP_IDE_CONFIG=serverName=<serverName>
```

Replace <serverName> with the "name" you added while adding a server in PHPStorm! If they don't match, it won't work.
Alternatively you can add additional options for XDebug here like;

```
XDEBUG_CONFIG=remote_host="host.docker.internal" remote_autostart=1 profiler_enable=1
```

You get the idea! (just remove `xdebug.` prefix from your usual xdebug.ini file)

### PHP-CLI & PHPStorm
**IMPORTANT!!! Make sure you have a server added first!**
* File -> Settings -> Languages & Frameworks -> PHP
* Click `...` button on the right end of CLI Interpreter row.
* Select `Docker` under **Remote**
* Select Server (the one we created before)
* Select your image (for example php-cli here)
* Save your settings.

Now back to the window where set saw **CLI Interpreter** row, 2 rows under it find **Docker container** row and far 
right side of it click on *opened folder icon*

* In **Volume Bindings** click on `+` button
* Container Path: `/var/www` (absolute path to the project root in container)
* Host Path: `/home/my-user/projects/my-cool-project` wherever you keep the project locally (absolute path)
* Save your settings

You can also add any Environment values you need here.

Please note that you should not delete (at current latest version, you can't anyway) the one that's automatically added (it is with `/opt/project/`)

Now all we have to do is to add the CLI command we want to run to PHPStorm

* Run -> Edit Configurations
* Click `+` button and Select `PHP Script`
* Give it a name, for example `doctrine:migrations:migrate`
* Configuration -> File: `<absolute path in your local>bin/console`
* Configuration -> Arguments: `doctrine:migrations:migrate`

Once these are set, you can see it in top right corner of PHPStorm (where you can enable / disable xdebug) just 
put a break point & select the file and click debug / bug icon and debug. CLI interpreter settings will kick in and 
the command will be run inside the container and you will be able to debug. 
