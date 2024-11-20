# Laravel + Docker + PgSQL

Just a sample project to experiment with this combo.

## How to use

Start the project with `docker-compose up -d`. This will launch a PgSQL database, a pgAdmin management interface, and a PHP shell to run scripts on.

The database will also be exposed to the host on the standard 5432 TCP port so you can also use local PgSQL clients like TablePlus.

The pgAdmin interface is availble at [http://127.0.0.1:4321/]().

The PHP shell also exposes port 8000 to the host, but by default nothing is running on this container. You should use `docker-compose exec app /bin/bash` to run your commands in there.

By default the `app` docker compose service, the PHP shell, will mount the local folder under `/app`. After exec'ing into the container, `cd /app` to see your code.
