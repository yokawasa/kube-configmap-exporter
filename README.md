# kubecmf
Kubernetes ConfigMap files exporter and importer

## Usage

```txt
Usage: kubecmf <action> -c <configmap> -n <namespace> [-f <file|dir>] [-t <dir>] options
OPTIONS:
  <action>                 'import' or 'export'
                             o import - import ConfigMap from a file or files
                             o export - export ConfigMap to a file or files
  -c, --configmap <name>   ConfigMap name
  -n, --namespace <name>   Namespace ('default' by default)
  -f, --from <file|dir>    A file or directry to import
  -t, --to <dir>           Direcotry to export
  -r, --replace            Replace ConfigMap if already exists
  -h, --help               Show this message
  -v, --version            Show this command's version
```

## HOW TO USE 
```sh
# Export ConfigMap named <name> into <dir>
$ kubecmf export -c <name> -t <dir>

# Import files under directory to ConfigMap named <name>
$ kubecmf import -c <name> -f <dir>

# Import a single <file> to ConfigMap named <name>
$ kubecmf import -c <name> -f <file>

# Import multiple files <file1> <file2> .. to ConfigMap named <name>
$ kubecmf import -c <name> -f <file1> -f <file2>

# Import <file> to ConfigMap named <name> ( Delete and Create ConfigMap if ConfigMap <name> exists)
$ kubecmf import -c <name> -f <file> -r
```

## Sample Scenario

You have the following multiple config files under `samples` directry:
```sh
$ tree samples

samples
├── database.yml
├── nginx.conf
└── uwsgi.ini
```

Now you create ConfigMap named `my-config` and import these files above into it by using `kubecmf`. 
```sh
$ kubecmf import -c my-config -f samples
```

Let's check how these config files are imported into the ConfigMap `my-config`.
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
        "name": "my-config",
        "namespace": "default",
        "resourceVersion": "2843317",
        "selfLink": "/api/v1/namespaces/default/configmaps/my-config",
        "uid": "01a14c9b-e8e6-11e8-b8ca-166cb263b9b6"
    }
}
```

Then, you export ConfigMap `my-config` to a directory named `exports` in your local filesystem.
```sh
$ mkdir exports
$ kubecmf export -c my-config -t exports
```

Let's check how ConfigMap `my-config` is exported to the directory `exports`.
```sh
$ tree exports
exports
├── database.yml
├── nginx.conf
└── uwsgi.ini
```

Finally, you modify these files and want to re-import them into the same ConfigMap named `my-config`. You import them using `kubecmf` command with `-r` option (means `replace`).
```sh
$ kubecmf import -c my-config -f samples -r
```
>[NOTE] In `replace` operation, `my-config` ConfigMap is supposed to be deleted and re-created with the same name.


## Prerequisite

- [kubectl](https://kubernetes.io/docs/reference/kubectl/kubectl/) - `kubecmf` uses `kubectl` to access Kubernetes API to import or to export ConfigMap
- [jq](https://stedolan.github.io/jq/) - `kubecmf` uses `jq` in exporting ConfigMap

## Installation

```sh
sudo git clone https://github.com/yokawasa/kubecmf /opt/kubecmf
sudo ln -s /opt/kubecmf/kubecmf /usr/local/bin/kubecmf
```

## License
This project is [Apache Licensed](LICENSE)