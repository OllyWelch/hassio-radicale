#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Add-on: Radicale
# Creates the server configuration
# ==============================================================================
declare usersfile
declare username
declare password

usersfile="/data/users"

bashio::log.info "Checking users file exists..."
if [ ! -e "${usersfile}" ] ; then
    bashio::log.info "Creating users file..."
    touch "${usersfile}"
    bashio::log.info "User file created"
    
else
    bashio::log.info "User file exists."
fi

for user in $(bashio::config 'users|keys'); do
    username=$(bashio::config "users[${user}].username")
    password=$(bashio::config "users[${user}].password")
    echo "${password}" | htpasswd -iB ${usersfile} ${username}
done