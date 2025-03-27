{{/*
  Return the short name of this chart.
*/}}
{{- define "n8n-application.name" -}}
{{ .Chart.Name | default "n8n-application" }}
{{- end }}

{{/*
  Return the full name of this chart.
*/}}
{{- define "n8n-application.fullname" -}}
{{ .Release.Name }}-{{ include "n8n-application.name" . }}
{{- end }}
