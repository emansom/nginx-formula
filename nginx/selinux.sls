nginx_selinux_activate:
  selinux.module:
    - name: nginx
    - module_state: Enabled
