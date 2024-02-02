{{/*
Returns custom hostname
*/}}
{{- define "janus-idp.hostname" -}}
    {{- if .Values.global.host -}}
        {{- .Values.global.host -}}
    {{- else if .Values.global.clusterRouterBase -}}
        {{- printf "%s-%s.%s" (include "common.names.fullname" .) .Release.Namespace .Values.global.clusterRouterBase -}}
    {{/*
    Attempt to obtain a fallback value for the hostname from the openshift cluster if both global.host and global.clusterRouterBase are "" and if deployed on Openshift
    */}}
    {{- else if .Capabilities.APIVersions.Has "config.openshift.io/v1/Ingress" }}  
        {{- $cluster := (lookup "config.openshift.io/v1" "Ingress" "" "cluster") -}}
        {{- if and (hasKey $cluster "spec") (hasKey $cluster.spec "domain") }}
            {{- printf "%s-%s.%s" (include "common.names.fullname" .) .Release.Namespace $cluster.spec.domain -}}
        {{- else -}}
            {{ fail "Unable to generate hostname, OCP Ingress Resource is missing `spec.domain` field. Please provide a valid hostname in `global.host` or `global.clusterRouterBase` instead" }}
        {{- end }}
    {{- else -}}
        {{ fail "Unable to generate hostname, please provide a valid hostname in `global.host` or `global.clusterRouterBase`" }}
    {{- end -}}
{{- end -}}

{{/*
Returns a secret name for service to service auth
*/}}
{{- define "janus-idp.backend-secret-name" -}}
    {{- if .Values.global.auth.backend.existingSecret -}}
        {{- .Values.global.auth.backend.existingSecret -}}
    {{- else -}}
        {{- include "common.names.fullname" . -}}-auth
    {{- end -}}
{{- end -}}

{{/*
Sets the secretKeyRef name for Backstage to the PostgreSQL existing secret if it present
*/}}
{{- define "janus-idp.postgresql.secretName" -}}
    {{- if ((((.Values).global).postgresql).auth).existingSecret -}}
        {{- .Values.global.postgresql.auth.existingSecret -}}
    {{- else if .Values.postgresql.auth.existingSecret -}}
        {{- .Values.postgresql.auth.existingSecret -}}
    {{- else -}}
        {{- printf "%s-%s" .Release.Name "postgresql" -}}
    {{- end -}}
{{- end -}}

{{/*
Get the password secret.
Referenced from: https://github.com/bitnami/charts/blob/main/bitnami/postgresql/templates/_helpers.tpl#L94-L105
*/}}
{{- define "postgresql.v1.secretName" -}}
    {{- if .Values.global.postgresql.auth.existingSecret -}}
        {{- printf "%s" (tpl .Values.global.postgresql.auth.existingSecret $) -}}
    {{- else if .Values.auth.existingSecret -}}
        {{- printf "%s" (tpl .Values.auth.existingSecret $) -}}
    {{- else -}}
        {{- printf "%s" (include "common.names.fullname" .) -}}
    {{- end -}}
{{- end -}}
