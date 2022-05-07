# nginx.h5bp
#
# Configures NGINX with more sane and modern defaults

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ '/libtofs.jinja' import files_switch with context %}

nginx_h5bp_mime_types:
  file.managed:
    - name: /etc/nginx/mime.types
    - source: {{ files_switch(['mime.types'], 'nginx_h5bp_mime_types') }}
