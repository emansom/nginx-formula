nginx_h5bp_mime_types:
  file.managed:
    - name: /etc/nginx/mime.types
    - source: {{ files_switch(['mime.types'], 'nginx_h5bp_mime_types') }}
