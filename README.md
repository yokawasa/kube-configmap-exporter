# kube-configmap-exporter
Kubernetes ConfigMap Exporter

## Usage

```txt
Usage: kube-configmap-exporter <name> -t <dir> options

Options:
  <name>                   ConfigMap name to export
  -n, --namespace <name>   Namespace ('default' by default)
  -t, --to <dir>           Directory onto which each configmap data is stored
                           as a file named each configmap key
  -h, --help               Show this message
  -v, --version            Show this command's version

Example:
  # Export configmap "mycm" in namespace "myns" onto directory "/tmp/"
  kube-configmap-exporter mycm -n myns -t /tmp
```

## Prerequisite

- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/) - `kube-configmap-exporter` uses `kubectl` to access Kubernetes API to import or to export ConfigMap
- [jq](https://stedolan.github.io/jq/) - `kube-configmap-exporter` uses `jq` in exporting ConfigMap

## Installation

```sh
sudo git clone https://github.com/yokawasa/kube-configmap-exporter /opt/kube-configmap-exporter
sudo ln -s /opt/kube-configmap-exporter/kube-configmap-exporter /usr/local/bin/kube-configmap-exporter
```

## Quickstart
Get copy of kube-configmap-exporter
```sh
$ git clone https://github.com/yokawasa/kube-configmap-exporter
cd kube-configmap-exporter
```


You have the following test files under `tests/files` directry:
```sh
$ tree tests/files

tests/files
├── database.yml
├── nginx.conf
└── uwsgi.ini
```

Now you create ConfigMap named `mycm` and import these files above into it by using `kubectl`. 
```sh
$ kubectl create configmap mycm --from-file tests/files
```

Then, check how these config files are imported into the ConfigMap `mycm`.
```sh
$ kubectl get cm my-config -o json

{
    "apiVersion": "v1",
    "data": {
        "database.yml": "....",
        "nginx.conf": "....",
        "uwsgi.ini": "...."
    },
    "kind": "ConfigMap",
    "metadata": {
        "creationTimestamp": "2018-11-15T14:52:00Z",
        "name": "mycm",
        "namespace": "default",
        "resourceVersion": "2843317",
        "selfLink": "/api/v1/namespaces/default/configmaps/mycm",
        "uid": "01a14c9b-e8e6-11e8-b8ca-166cb263b9b6"
    }
}
```

Finally, you export ConfigMap `mycm` onto a directory named `tests/exports` using `kube-configmap-exporter`
```sh
$ mkdir tests/exports
$ kube-configmap-exporter mycm -t tests/exports
```

Let's check  exported files in `tests/exports` directory.
```sh
$ tree tests/exports
exports
├── database.yml
├── nginx.conf
└── uwsgi.ini
```

## License
This project is [Apache Licensed](LICENSE)

## Contributing
Bug reports, pull requests, and any feedback are welcome on GitHub at https://github.com/yokawasa/kube-configmap-exporter.
