# nginx.h5bp
#
# Configures NGINX with more sane and modern defaults

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ '/libtofs.jinja' import files_switch with context %}
{%- from tplroot ~ '/map.jinja' import nginx with context %}

nginx_h5bp_config_dir:
  file.directory:
    - name: /etc/nginx
    - user: root
    - group: root
    - mode: 0755

nginx_h5bp_share_dir:
  file.directory:
    - name: /usr/share/nginx/h5bp
    - user: root
    - group: root
    - mode: 0550
    - makedirs: True

nginx_h5bp_checkout:
  git.detached:
    - name: https://github.com/h5bp/server-configs-nginx.git
    - target: /usr/share/nginx/h5bp
    - rev: 4.2.0
    - require:
      - file: nginx_h5bp_share_dir

nginx_h5bp_directory:
  file.symlink:
    - name: /etc/nginx/h5bp
    - target: /usr/share/nginx/h5bp/h5bp
    - require:
      - git: nginx_h5bp_checkout
      - file: nginx_h5bp_config_dir

nginx_h5bp_mime_types:
  file.symlink:
    - name: /etc/nginx/mime.types
    - target: /usr/share/nginx/h5bp/mime.types
    - force: True
    - require:
      - git: nginx_h5bp_checkout
      - file: nginx_h5bp_config_dir

nginx_h5bp_set_user:
  file.keyvalue:
    - name: /usr/share/nginx/h5bp/nginx.conf
    - key_values:
        user: '{{ nginx.lookup.webuser }};'
    - separator: ' '
    - uncomment: '# '
    - require:
      - git: nginx_h5bp_checkout

nginx_h5bp_cert_directory:
  file.directory:
    - name: /etc/nginx/certs
    - mode: 0600
    - require:
      - file: nginx_h5bp_config_dir

nginx_h5bp_cert_default_key:
  x509.private_key_managed:
   - name: /etc/nginx/certs/default.key
   - bits: 4096
   - require:
     - file: nginx_h5bp_cert_directory

nginx_h5bp_cert_default_pub:
  x509.certificate_managed:
    - name: /etc/nginx/certs/default.crt
    - signing_private_key: /etc/nginx/certs/default.key
    - CN: www2.example.com
    - subjectAltName: 'DNS:www2.example.com'
    - days_valid: 3650
    - days_remaining: 0
    - require:
      - file: nginx_h5bp_cert_directory
