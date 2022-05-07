nginx_firewalld_service:
  firewalld.service:
    - name: nginx
    - ports:
      - 80/tcp
      - 443/tcp

nginx_firewalld_open:
  firewalld.present:
    - name: public
    - services:
      - nginx
