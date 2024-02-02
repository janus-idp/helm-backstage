# Janus-IDP Backstage Helm Chart

> **:exclamation: This Helm Chart is deprecated!**

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/janus-idp&style=flat-square)](https://artifacthub.io/packages/search?repo=janus-idp)
![Version: 2.12.5](https://img.shields.io/badge/Version-2.12.5-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

DEPRECATED A Helm chart for deploying a Backstage application. See https://github.com/redhat-developer/rhdh-chart

**Homepage:** <https://janus-idp.io>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Janus-IDP |  | <https://janus-idp.io> |

## Source Code

* <https://github.com/redhat-developer/rhdh-chart>
* <https://github.com/janus-idp/backstage-showcase>

---

[Janus-IDP](https://janus-idp.io/) Backstage chart is an opinionated flavor of the upstream chart located at [backstage/charts](https://github.com/backstage/charts). It extends the upstream chart with additional OpenShift specific functionality and provides opinionated values.

[Backstage](https://backstage.io) is an open platform for building developer portals. Powered by a centralized software catalog, Backstage restores order to your microservices and infrastructure and enables your product teams to ship high-quality code quickly — without compromising autonomy.

Backstage unifies all your infrastructure tooling, services, and documentation to create a streamlined development environment from end to end.

**This chart offers an opinionated OpenShift-specific experience.** It is based on and directly depends on an upstream canonical [Backstage Helm chart](https://github.com/backstage/charts/tree/main/charts/backstage). For less opinionated experience, please consider using the upstream chart directly.

This chart extends all the features in the upstream chart in addition to including OpenShift only features. It is not recommended to use this chart on other platforms.

## Usage

Charts are available in the following formats:

- [Chart Repository](https://helm.sh/docs/topics/chart_repository/)
- [OCI Artifacts](https://helm.sh/docs/topics/registries/)

### Installing from the Chart Repository

The following command can be used to add the chart repository:

```console
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add backstage https://backstage.github.io/charts
helm repo add janus-idp https://janus-idp.github.io/helm-backstage
```

Once the chart has been added, install this chart. However before doing so, please review the default `values.yaml` and adjust as needed.

- If your cluster doesn't provide PVCs, you should disable PostgreSQL persistence via:

   ```yaml
   upstream:
     postgresql:
       primary:
         persistence:
           enabled: false
   ```

```console
helm upgrade -i <release_name> janus-idp/backstage
```

### Installing from an OCI Registry

Note: this repo is deprecated. New chart updates will be in `[redhat-developer/rhdh-chart](https://github.com/orgs/redhat-developer/packages/container/package/rhdh-chart%2Fbackstage)` starting in 2024.

Chart is also available in OCI format. The list of available releases can be found [here](https://github.com/orgs/janus-idp/packages/container/package/helm-backstage%2Fbackstage).

Install one of the available versions:

```shell
helm upgrade -i <release_name> oci://ghcr.io/redhat-developer/rhdh-chart/backstage --version=<version>
```

or

```shell
helm upgrade -i <release_name> oci://ghcr.io/janus-idp/helm-backstage/backstage --version=<version>
```

## Backstage Chart

More information can be found by inspecting the [backstage chart](charts/backstage).
