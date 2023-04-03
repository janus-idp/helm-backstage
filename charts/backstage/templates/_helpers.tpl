{{/*
Return the proper Docker Image Registry Secret Names
*/}}
{{- define "janusIdp.renderImageBuildPullSecrets" -}}
{{- include "common.images.renderPullSecrets" (dict "images" (list .Values.build.buildConfig) "context" $) -}}
{{- end -}}


{{/*
Return the proper image name
THIS IS AN OVERRIDE of upstream helper! 

https://github.com/backstage/charts/blob/13a408cc070005a9960a5e2a3f6ebfdd8c77d8d2/charts/backstage/templates/_helpers.tpl#L4
*/}}
{{- define "backstage.image" -}}
{{- $templatedImage := include "common.images.image" (dict "imageRoot" .Values.backstage.image "global" .Values.global) -}}
{{ include "common.tplvalues.render" ( dict "value" $templatedImage "context" $ ) }}
{{- end -}}
