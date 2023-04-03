
# Janus-IDP Backstage Helm Chart

[![Artifact Hub](https://img.shields.io/endpoint?url=https://artifacthub.io/badge/repository/janus-idp&style=flat-square)](https://artifacthub.io/packages/search?repo=janus-idp)
![Version: 2.1.0](https://img.shields.io/badge/Version-2.1.0-informational?style=flat-square)
![Type: application](https://img.shields.io/badge/Type-application-informational?style=flat-square)

A Helm chart for deploying a Backstage application

**Homepage:** <https://janus-idp.io>

## Maintainers

| Name | Email | Url |
| ---- | ------ | --- |
| Janus-IDP |  | <https://janus-idp.io> |

## Source Code

* <https://github.com/janus-idp/helm-backstage>
* <https://github.com/janus-idp/backstage-showcase>

---

[Janus-IDP](https://janus-idp.io/) Backstage chart is an oppinionated flavor of the upstream chart located at [backstage/charts](https://github.com/backstage/charts). It extends the upstream chart with additional OpenShift specific functionality and provides oppinionated values.

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
helm repo add janus-idp https://janus-idp.github.io/helm-backstage
```

Once the chart has been added, install this chart. However before doing so, please review the default `values.yaml` and adjust as needed.

- To get proper connection between frontend and backend of Backstage please update the `apps.example.com` to match your cluster host:

   ```yaml
   upstream:
     backstage:
       appConfig:
         app:
           baseUrl: 'https://{{- print .Release.Name "-" .Release.Namespace -}}.apps.example.com'
         backend:
           baseUrl: 'https://{{- print .Release.Name "-" .Release.Namespace -}}.apps.example.com'
           cors:
             origin: 'https://{{- print .Release.Name "-" .Release.Namespace -}}.apps.example.com'
   ```

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

Chart is also available in OCI format. The list of available releases can be found [here](https://github.com/janus-idp/helm-backstage/pkgs/container/charts%2Fbackstage).

Install one of the available versions:

```shell
helm upgrade -i oci://ghcr.io/janus-idp/helm-backstage/backstage --version=<version>
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
| https://backstage.github.io/charts | upstream(backstage) | 1.x.x |
| https://charts.bitnami.com/bitnami | common | 2.x.x |

## Values

| Key | Description | Type | Default |
|-----|-------------|------|---------|
| build | Build Backstage image in-cluster | object | `{"buildConfig":{"annotations":{},"completionDeadlineSeconds":1800,"contextDir":"","failedBuildsHistoryLimit":5,"ref":"main","resources":{"limits":{"cpu":"500m","memory":"2Gi"}},"sourceSecretName":"","strategy":{"docker":{"dockerfilePath":"./Dockerfile","pullSecrets":[]},"source":{"scripts":"https://raw.githubusercontent.com/janus-idp/redhat-backstage-build/add-s2i/.s2i/bin/"},"type":"Source"},"successfulBuildsHistoryLimit":5,"triggers":[{"type":"ConfigChange"},{"type":"ImageChange"}],"uri":"https://github.com/janus-idp/backstage-showcase.git"},"enabled":false,"imageStream":{"annotations":{}}}` |
| build.buildConfig | BuildConfig specific values | object | `{"annotations":{},"completionDeadlineSeconds":1800,"contextDir":"","failedBuildsHistoryLimit":5,"ref":"main","resources":{"limits":{"cpu":"500m","memory":"2Gi"}},"sourceSecretName":"","strategy":{"docker":{"dockerfilePath":"./Dockerfile","pullSecrets":[]},"source":{"scripts":"https://raw.githubusercontent.com/janus-idp/redhat-backstage-build/add-s2i/.s2i/bin/"},"type":"Source"},"successfulBuildsHistoryLimit":5,"triggers":[{"type":"ConfigChange"},{"type":"ImageChange"}],"uri":"https://github.com/janus-idp/backstage-showcase.git"}` |
| build.buildConfig.annotations | Additional annotations to apply to the BuildConfig | object | `{}` |
| build.buildConfig.completionDeadlineSeconds | Build timeout in seconds. Defaults to 30 minutes | int | `1800` |
| build.buildConfig.contextDir | Source repository context folder <br /> Ref: https://docs.openshift.com/container-platform/4.12/cicd/builds/creating-build-inputs.html#builds-source-code_creating-build-inputs | string | `""` |
| build.buildConfig.failedBuildsHistoryLimit | Amount of failed builds to keep in history | int | `5` |
| build.buildConfig.ref | Source repository reference <br /> Ref: https://docs.openshift.com/container-platform/4.12/cicd/builds/creating-build-inputs.html#builds-source-code_creating-build-inputs | string | `"main"` |
| build.buildConfig.resources | Resource requests/limits <br /> Ref: https://kubernetes.io/docs/user-guide/compute-resources/ | object | `{"limits":{"cpu":"500m","memory":"2Gi"}}` |
| build.buildConfig.sourceSecretName | Secrets to be used when cloning the source repository <br /> Ref: https://docs.openshift.com/container-platform/4.12/cicd/builds/creating-build-inputs.html#builds-adding-source-clone-secrets_creating-build-inputs | string | `""` |
| build.buildConfig.strategy | Build strategy settings | object | `{"docker":{"dockerfilePath":"./Dockerfile","pullSecrets":[]},"source":{"scripts":"https://raw.githubusercontent.com/janus-idp/redhat-backstage-build/add-s2i/.s2i/bin/"},"type":"Source"}` |
| build.buildConfig.strategy.docker | Docker build strategy: Use Buildah to build a container image from a Dockerfile | object | `{"dockerfilePath":"./Dockerfile","pullSecrets":[]}` |
| build.buildConfig.strategy.docker.dockerfilePath | Path to dockerfile relative to contextDir <br /> Ref: https://docs.openshift.com/container-platform/4.12/cicd/builds/build-strategies.html#builds-strategy-dockerfile-path_build-strategies | string | `"./Dockerfile"` |
| build.buildConfig.strategy.docker.pullSecrets | Pull secrets to be used for images referenced in Dockerfile <br /> Ref: https://docs.openshift.com/container-platform/4.12/cicd/builds/creating-build-inputs.html#builds-docker-credentials-private-registries_creating-build-inputs | list | `[]` |
| build.buildConfig.strategy.source | Source-to-image build strategy | object | `{"scripts":"https://raw.githubusercontent.com/janus-idp/redhat-backstage-build/add-s2i/.s2i/bin/"}` |
| build.buildConfig.strategy.source.scripts | Override S2I scripts by custom location. Defaults to Janus-IDP scripts that work for Backstage out of the box <br /> Ref: https://docs.openshift.com/container-platform/4.12/cicd/builds/build-strategies.html#builds-strategy-s2i-override-builder-image-scripts_build-strategies-docker | string | `"https://raw.githubusercontent.com/janus-idp/redhat-backstage-build/add-s2i/.s2i/bin/"` |
| build.buildConfig.strategy.type | Build strategy selector. This chart currently supports either "Source" or "Docker" values. | string | `"Source"` |
| build.buildConfig.successfulBuildsHistoryLimit | Amount of successful builds to keep in history | int | `5` |
| build.buildConfig.triggers | Triggers that initiate a new build. <br /> Ref: https://docs.openshift.com/container-platform/4.12/cicd/builds/triggering-builds-build-hooks.html | list | `[{"type":"ConfigChange"},{"type":"ImageChange"}]` |
| build.buildConfig.uri | Source repository URI <br /> Ref: https://docs.openshift.com/container-platform/4.12/cicd/builds/creating-build-inputs.html#builds-source-code_creating-build-inputs | string | `"https://github.com/janus-idp/backstage-showcase.git"` |
| build.enabled | Enables creation of BuildConfig and ImageStream resources | bool | `false` |
| build.imageStream | ImageStream specific values | object | `{"annotations":{}}` |
| build.imageStream.annotations | Additional annotations to apply to the ImageStream | object | `{}` |
| route | OpenShift Route parameters | object | `{"annotations":{},"enabled":true,"host":"","path":"/","tls":{"caCertificate":"","certificate":"","destinationCACertificate":"","enabled":true,"insecureEdgeTerminationPolicy":"Redirect","key":"","termination":"edge"},"wildcardPolicy":"None"}` |
| route.annotations | Route specific annotations | object | `{}` |
| route.enabled | Enable the creation of the route resource | bool | `true` |
| route.host | Set the host attribute to a custom value. If not set, OpenShift will generate it, please make sure to match your baseUrl | string | `""` |
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

## Opinionated Backstage deployment

This chart defaults to an opinionated deployment of Backstage that provides user with a usable Backstage instance out of the box.

Features enabled by the default chart configuration:

1. Uses [janus-idp/backstage-showcase](https://github.com/janus-idp/backstage-showcase/) that pre-loads a lot of useful plugins and features
2. Exposes a `Route` for easy access to the instance
3. Enables OpenShift-compatible PostgreSQL database storage

For additional instance features please consuls [documentation for `janus-idp/backstage-showcase`](https://github.com/janus-idp/backstage-showcase/).

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

This charts defaults to using the Janus-IDP Backstage Showcase image that is OpenShift compatible:

```
quay.io/janus-idp/backstage-showcase:latest
```

Additionally this chart enhances the upstream Backstage chart with following OpenShift-specific features:

### OpenShift Routes

This chart offers a drop-in replacement for the `Ingress` resource already provided by the upstream chart via an OpenShift `Route`.

Please enable it using following values:

```yaml
# values.yaml
upstream:
  backstage:
    extraEnvVars:
      - name: "APP_CONFIG_app_baseUrl"
        value: "https://{{ .Values.global.host }}"
      - name: "APP_CONFIG_backend_baseUrl"
        value: "https://{{ .Values.global.host }}"
      - name: "APP_CONFIG_backend_cors_origin"
        value: "https://{{ .Values.global.host }}"
  ingress:
    enabled: false
route:
  enabled: true
  host: "{{ .Values.global.host }}"
  tls:
    enabled: true

global:
  host: backstage.apps.example.com
```

### OpenShift Build

In addition to providing a complete image for deployment, this feature allows user to refence a Backstage repository instead. This repository will be turned into an image in-cluster through OpenShift BuildConfig. In order to properly propagate the image to the Deployment, use following values as a baseline:

```yaml
upstream:
  backstage:
    image:
      # Make the Deployment reference an image from local image registry in OpenShift
      registry: ''
      repository: '{{ .Release.Namespace }}/{{ include "common.names.fullname" . }}'

    annotations:
      # Enable rollouts when new image becomes available
      image.openshift.io/triggers: |
        [{"from":{"kind":"ImageStreamTag","name":"{{ include "common.names.fullname" . }}"},"fieldPath":"spec.template.spec.containers[0].image"}]

    podAnnotations:
      # Enables ImageStream lookup
      alpha.image.policy.openshift.io/resolve-names: '*'

build:
  enabled: true
```

The process can be furtner customized through the `build` value in `values.yaml` file. For more details see [Values section](#values) above.
