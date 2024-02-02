
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

## TL;DR

```console
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo add backstage https://backstage.github.io/charts
helm repo add janus-idp https://janus-idp.github.io/helm-backstage

helm install my-release janus-idp/backstage
```

## Introduction

This chart bootstraps a [Backstage](https://backstage.io/docs/deployment/docker) deployment on a [Kubernetes](https://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.2.0+
- PV provisioner support in the underlying infrastructure
- [Backstage container image](https://backstage.io/docs/deployment/docker)

## Usage

Chart is available in the following formats:

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

> **Tip**: List all releases using `helm list`

### Uninstalling the Chart

To uninstall/delete the `my-backstage-release` deployment:

```console
helm uninstall my-backstage-release
```

The command removes all the Kubernetes components associated with the chart and deletes the release.

## Requirements

Kubernetes: `>= 1.19.0-0`

| Repository | Name | Version |
|------------|------|---------|
| https://backstage.github.io/charts | upstream(backstage) | 1.8.2 |
| https://charts.bitnami.com/bitnami | common | 2.14.1 |

## Values

| Key | Description | Type | Default |
|-----|-------------|------|---------|
| global.auth | Enable service authentication within Backstage instance | object | `{"backend":{"enabled":true,"existingSecret":"","value":""}}` |
| global.auth.backend | Backend service to service authentication <br /> Ref: https://backstage.io/docs/auth/service-to-service-auth/ | object | `{"enabled":true,"existingSecret":"","value":""}` |
| global.auth.backend.enabled | Enable backend service to service authentication, unless configured otherwise it generates a secret value | bool | `true` |
| global.auth.backend.existingSecret | Instead of generating a secret value, refer to existing secret | string | `""` |
| global.auth.backend.value | Instead of generating a secret value, use the following value | string | `""` |
| global.clusterRouterBase | Shorthand for users who do not want to specify a custom HOSTNAME. Used ONLY with the DEFAULT upstream.backstage.appConfig value and with OCP Route enabled. | string | `""` |
| global.dynamic.includes | Array of YAML files listing dynamic plugins to include with those listed in the `plugins` field. Relative paths are resolved from the working directory of the initContainer that will install the plugins (`/opt/app-root/src`). | list | `["dynamic-plugins.default.yaml"]` |
| global.dynamic.includes[0] | List of dynamic plugins included inside the `janus-idp/backstage-showcase` container image, some of which are disabled by default. This file ONLY works with the `janus-idp/backstage-showcase` container image. | string | `"dynamic-plugins.default.yaml"` |
| global.dynamic.plugins | List of dynamic plugins, possibly overriding the plugins listed in `includes` files. Every item defines the plugin `package` as a [NPM package spec](https://docs.npmjs.com/cli/v10/using-npm/package-spec), an optional `pluginConfig` with plugin-specific backstage configuration, and an optional `disabled` flag to disable/enable a plugin listed in `includes` files. It also includes an `integrity` field that is used to verify the plugin package [integrity](https://w3c.github.io/webappsec-subresource-integrity/#integrity-metadata-description). | list | `[]` |
| global.host | Custom hostname shorthand, overrides `global.clusterRouterBase`, `upstream.ingress.host`, `route.host`, and url values in `upstream.backstage.appConfig`. If neither `global.clusterRouterBase` nor `global.host` are set, the helm chart will attempt to autofill with the hostname of the [OCP Ingress configuration](https://access.redhat.com/documentation/en-us/openshift_container_platform/4.14/html/networking/configuring-ingress#nw-installation-ingress-config-asset_configuring-ingress) | string | `""` |
| route | OpenShift Route parameters | object | `{"annotations":{},"enabled":true,"host":"{{ .Values.global.host }}","path":"/","tls":{"caCertificate":"","certificate":"","destinationCACertificate":"","enabled":true,"insecureEdgeTerminationPolicy":"Redirect","key":"","termination":"edge"},"wildcardPolicy":"None"}` |
| route.annotations | Route specific annotations | object | `{}` |
| route.enabled | Enable the creation of the route resource | bool | `true` |
| route.host | Set the host attribute to a custom value. If not set, OpenShift will generate it, please make sure to match your baseUrl | string | `"{{ .Values.global.host }}"` |
| route.path | Path that the router watches for, to route traffic for to the service. | string | `"/"` |
| route.tls | Route TLS parameters <br /> Ref: https://docs.openshift.com/container-platform/4.9/networking/routes/secured-routes.html | object | `{"caCertificate":"","certificate":"","destinationCACertificate":"","enabled":true,"insecureEdgeTerminationPolicy":"Redirect","key":"","termination":"edge"}` |
| route.tls.caCertificate | Cert authority certificate contents. Optional | string | `""` |
| route.tls.certificate | Certificate contents | string | `""` |
| route.tls.destinationCACertificate | Contents of the ca certificate of the final destination. <br /> When using reencrypt termination this file should be provided in order to have routers use it for health checks on the secure connection. If this field is not specified, the router may provide its own destination CA and perform hostname validation using the short service name (service.namespace.svc), which allows infrastructure generated certificates to automatically verify. | string | `""` |
| route.tls.enabled | Enable TLS configuration for the host defined at `route.host` parameter | bool | `true` |
| route.tls.insecureEdgeTerminationPolicy | Indicates the desired behavior for insecure connections to a route. <br /> While each router may make its own decisions on which ports to expose, this is normally port 80. The only valid values are None, Redirect, or empty for disabled. | string | `"Redirect"` |
| route.tls.key | Key file contents | string | `""` |
| route.tls.termination | Specify TLS termination. | string | `"edge"` |
| route.wildcardPolicy | Wildcard policy if any for the route. Currently only 'Subdomain' or 'None' is allowed. | string | `"None"` |
| upstream | Upstream Backstage [chart configuration](https://github.com/backstage/charts/blob/main/charts/backstage/values.yaml) | object | Use Openshift compatible settings |
| upstream.backstage.extraVolumes[0] | Ephemeral volume that will contain the dynamic plugins installed by the initContainer below at start. | object | `{"ephemeral":{"volumeClaimTemplate":{"spec":{"accessModes":["ReadWriteOnce"],"resources":{"requests":{"storage":"1Gi"}}}}},"name":"dynamic-plugins-root"}` |
| upstream.backstage.extraVolumes[0].ephemeral.volumeClaimTemplate.spec.resources.requests.storage | Size of the volume that will contain the dynamic plugins. It should be large enough to contain all the plugins. | string | `"1Gi"` |
| upstream.backstage.initContainers[0].image | Image used by the initContainer to install dynamic plugins into the `dynamic-plugins-root` volume mount. It could be replaced by a custom image based on this one. | string | `quay.io/janus-idp/backstage-showcase:latest` |

## Opinionated Backstage deployment

This chart defaults to an opinionated deployment of Backstage that provides user with a usable Backstage instance out of the box.

Features enabled by the default chart configuration:

1. Uses [janus-idp/backstage-showcase](https://github.com/janus-idp/backstage-showcase/) that pre-loads a lot of useful plugins and features
2. Exposes a `Route` for easy access to the instance
3. Enables OpenShift-compatible PostgreSQL database storage

For additional instance features please consult the [documentation for `janus-idp/backstage-showcase`](https://github.com/janus-idp/backstage-showcase/tree/main/showcase-docs).

Additional features can be enabled by extending the default configuration at:

```yaml
upstream:
  backstage:
    appConfig:
      # Inline app-config.yaml for the instance
    extraEnvVars:
      # Additional environment variables
```

## Features

This charts defaults to using the [latest Janus-IDP Backstage Showcase image](https://quay.io/janus-idp/backstage-showcase:latest) that is OpenShift compatible:

```console
quay.io/janus-idp/backstage-showcase:latest
```

Additionally this chart enhances the upstream Backstage chart with following OpenShift-specific features:

### OpenShift Routes

This chart offers a drop-in replacement for the `Ingress` resource already provided by the upstream chart via an OpenShift `Route`.

OpenShift routes are enabled by default. In order to use the chart without it, please set `route.enabled` to `false` and switch to the `Ingress` resource via `upstream.ingress` values.

Routes can be further configured via the `route` field.

By default, the chart expects you to expose Backstage via the autogenerated hostname, which is automatically obtained from the OpenShift Ingress Configurations.

To manually provide the Backstage pod with the right context, please add the following value:

```yaml
# values.yaml
global:
  clusterRouterBase: apps.example.com
```

> Tip: you can use `helm upgrade -i --set global.clusterRouterBase=apps.example.com ...` instead of a value file

Custom hosts are also supported via the following shorthand:

```yaml
# values.yaml
global:
  host: backstage.example.com
```

> Note: Setting either `global.host` or `global.clusterRouterBase` will disable the automatic hostname discovery.
        When both fields are set, `global.host` will take precedence.
        These are just templating shorthands. For full manual configuration please pay attention to values under the `route` key.

Any custom modifications to how backstage is being exposed may require additional changes to the `values.yaml`:

```yaml
# values.yaml
upstream:
  backstage:
    appConfig:
      app:
        baseUrl: 'https://{{- include "janus-idp.hostname" . }}'
      backend:
        baseUrl: 'https://{{- include "janus-idp.hostname" . }}'
        cors:
          origin: 'https://{{- include "janus-idp.hostname" . }}'
```

### Vanilla Kubernetes compatibility mode

In order to deploy this chart on vanilla Kubernetes or any other non-OCP platform, please make sure to apply the following changes. Note that further customizations may be required, depending on your exact Kubernetes setup:

```yaml
# values.yaml
global:
  host: # Specify your own Ingress host as automatic hostname discovery is not supported outside of OpenShift
route:
  enabled: false  # OpenShift Routes do not exist on vanilla Kubernetes
upstream:
  ingress:
    enabled: true  # Use Kubernetes Ingress instead of OpenShift Route
  backstage:
    podSecurityContext:  # Vanilla Kubernetes doesn't feature OpenShift default SCCs with dynamic UIDs, adjust accordingly to the deployed image
      runAsUser: 1001
      runAsGroup: 1001
      fsGroup: 1001
  postgresql:
    primary:
      podSecurityContext:
        enabled: true
        fsGroup: 26
        runAsUser: 26
    volumePermissions:
      enabled: true
```
