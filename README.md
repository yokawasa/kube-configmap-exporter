# kubecmf
Kubernetes ConfigMap files importer and exporter

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
# Import <file> to ConfigMap named <name>
$ kubecmf import -c <name> -f <file>

# Import multiple files <file1> <file2> .. to ConfigMap named <name>
$ kubecmf import -c <name> -f <file1> -f <file2>

# Import files under directory to ConfigMap named <name>
$ kubecmf import -c <name> -f <dir>

# Import <file> to ConfigMap named <name> ( Delete and Create ConfigMap if ConfigMap <name> exists)
$ kubecmf import -c <name> -f <file> -r

# Export ConfigMap named <name> into <dir>
$ kubecmf export -c <name> -t <dir>
```

## Installation

```sh
sudo git clone https://github.com/yokawasa/kubecmf /opt/kubecmf
sudo ln -s /opt/kubecmf/kubecmf /usr/local/bin/kubecmf
```

## License
This project is [Apache Licensed](LICENSE)