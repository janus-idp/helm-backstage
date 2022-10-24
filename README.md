# helm-backstage

A [Helm](https://helm.sh) chart for [Backstage](https://backstage.io).

## Usage

Charts are available in the following formats:

* [Chart Repository](https://helm.sh/docs/topics/chart_repository/)
* [OCI Artifacts](https://helm.sh/docs/topics/registries/)

### Installing from the Chart Repository

The following command can be used to add the chart repository:

```shell
helm repo add redhat-developer-backstage https://redhat-developer.github.io/helm-backstage
helm repo update
```

Once the chart has been added, install one of the available charts:

```shell
helm upgrade -i <release_name> redhat-developer-backstage/backstage
```

### Installing from an OCI Registry

Charts are also available in OCI format. The list of available charts can be found [here](https://github.com/redhat-developer?tab=packages&repo_name=helm-backstage).

Install one of the available charts:

```shell
helm upgrade -i oci://ghcr.io/redhat-developer/helm-backstage/backstage --version=<version>
```

## Backstage Chart

More information can be found by inspecting the [backstage chart](charts/backstage).
