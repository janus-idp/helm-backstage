{{/*
Returns custom hostname
*/}}
{{- define "janus-idp.hostname" -}}
    {{- if .Values.global.host -}}
        {{- .Values.global.host -}}
    {{- else if .Values.global.clusterRouterBase -}}
        {{- printf "%s-%s.%s" (include "common.names.fullname" .) .Release.Namespace .Values.global.clusterRouterBase -}}
    {{- else -}}
        {{ fail "Unable to generate hostname" }}
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
