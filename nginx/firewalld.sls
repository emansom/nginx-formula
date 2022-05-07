nginx_firewalld_open_ports:
  firewalld.present:
    - name: public
    - services:
      - http
      - https
