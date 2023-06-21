# Backstage Helm Chart for OpenShift

[Backstage](https://backstage.io) is an open platform for building developer portals. Powered by a centralized software catalog, Backstage restores order to your microservices and infrastructure and enables your product teams to ship high-quality code quickly — without compromising autonomy.

Backstage unifies all your infrastructure tooling, services, and documentation to create a streamlined development environment from end to end.

**This chart offers an opinionated OpenShift-specific experience.** It is based on and directly depends on an upstream canonical [Backstage Helm chart](https://github.com/backstage/charts/tree/main/charts/backstage). For less opinionated experience, please consider using the upstream chart directly.

This chart extends all the features in the upstream chart in addition to including OpenShift only features. It is not recommended to use this chart on other platforms.

## Usage

Charts are available in the following formats:

* [Chart Repository](https://helm.sh/docs/topics/chart_repository/)
* [OCI Artifacts](https://helm.sh/docs/topics/registries/)

### Installing from the Chart Repository

The following command can be used to add the chart repository:

```console
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add backstage https://backstage.github.io/charts
helm repo add janus-idp https://janus-idp.github.io/helm-backstage
```

Once the chart has been added, install one of the available charts:

```console
helm upgrade -i <release_name> janus-idp/backstage
```

### Installing from an OCI Registry

Charts are also available in OCI format. The list of available charts can be found [here](https://github.com/orgs/janus-idp?tab=packages&repo_name=helm-backstage).

Install one of the available charts:

```shell
helm upgrade -i <release_name> oci://ghcr.io/janus-idp/helm-backstage/backstage --version=<version>
```

## Backstage Chart

More information can be found by inspecting the [backstage chart](charts/backstage).
