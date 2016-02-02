# docker-events-plugin

Simple plugin framework for docker events.

## Usage

```
Usage: docker-event-plugin [OPTION...] PLUGIN [PLUGIN_OPTION...]

PLUGIN:
  plugin file or directory

OPTION:
  -d, --debug         Debug mode
      --no-reconnect  Do not automatically reconnect on failure
      --help          Show help
  -v, --version       Show version

PLUGIN_OPTION:
  Passed to plugin
```

docker-events-plugin uses the docker command internally.
Therefore environment variables for docker is also available.

## How to create your plugin

See sample-plugin directory in repository.


## Support events

**Events related image**

```
delete, import, pull, push, tag, untag
```

Arguments that passed to the plugin.

``EVENT`` ``IMAGE`` ``DATETIME``


**Events related container**

```
archive-path, attach, commit, copy, create, destroy, die,
exists, export, extract-to-dir, kill, oom, pause, rename,
resize, restart, start, stop, top, unpause
```

Note: **exists** is not docker native event.
exists event is raised when containers found at before listening for events.

Arguments that passed to the plugin.

``EVENT`` ``CONTAINER`` ``IMAGE DATETIME``

**Events related docker exec**

```
exec_create, exec_start
```

Arguments that passed to the plugin.

``EVENT`` ``CONTAINER`` ``IMAGE`` ``DATETIME`` ``COMMAND``

**About events**

* https://docs.docker.com/engine/reference/commandline/events/

## Using pre-build docker image

It's useful for execute as a service.

**Connect to local docker server**

```
docker run --rm \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /path/to/plugin:/plugin \
  ko1nksm/docker-events-plugin [[OPTION...] exec [PLUGIN_OPTION...]]
```

**Connect to remote docker server**

```
docker run --rm \
  -e DOCKER_HOST=tcp://198.51.100.1:4243 \
  -v /path/to/plugin:/plugin \
  -v /path/to/your/docker-cert-path:/cert
  ko1nksm/docker-events-plugin [[OPTION...] exec [PLUGIN_OPTION...]]
```

### Special paths in container

| Path     | Description                                   |
| -------- | --------------------------------------------- |
| /plugin  | plugin file or directory                      |
| /cert    | DOCKER_CERT_PATH in container is set to /cert |


## License

MIT License
