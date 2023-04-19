##
# Nginx
##
#
# Reload configuration, start the new worker process with a new configuration, 
# gracefully shut down old worker processes.
#   also pass it via sudo so whoever is admin can reload it without calling you #
alias nginxreload='sudo /usr/local/nginx/sbin/nginx -s reload'

function nginx_t nginx-t nginxtest {
  sudo nginx -t
}

alias nginx_start='sudo service nginx start'
alias nginx_stop='sudo service nginx stop'
alias nginx_restart='sudo service nginx restart'

