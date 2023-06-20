{{/*
Returns custom hostname
*/}}
{{- define "janus-idp.hostname" -}}
    {{- if .Values.global.host -}}
        {{- .Values.global.host -}}
    {{- else if .Values.global.clusterRouterBase -}}
        {{- print .Release.Name "-" .Release.Namespace "." .Values.global.clusterRouterBase -}}
    {{- else -}}
        {{ fail "Unable to generate hostname" }}
    {{- end -}}
{{- end -}}
