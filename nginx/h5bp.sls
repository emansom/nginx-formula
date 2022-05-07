# nginx.h5bp
#
# Configures NGINX with more sane and modern defaults

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ '/libtofs.jinja' import files_switch with context %}

nginx_h5bp_checkout:
  git.detached:
    - name: https://github.com/h5bp/server-configs-nginx.git
    - target: /usr/share/nginx/h5bp
    - rev: 4.2.0

nginx_h5bp_directory:
  file.symlink:
    - name: /etc/nginx/h5bp
    - target: /usr/share/nginx/h5bp/h5bp

nginx_h5bp_mime_types:
  file.symlink:
    - name: /etc/nginx/mime.types
    - target: /usr/share/nginx/h5bp/mime.types
    - force: True
