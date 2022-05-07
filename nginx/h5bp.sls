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

nginx_h5bp_cert_directory:
  file.directory:
    - name: /etc/nginx/certs
    - mode: 0600

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
