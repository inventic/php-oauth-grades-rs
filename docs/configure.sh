#!/bin/sh
APP_NAME="php-oauth-grades-rs"

INSTALL_DIR=`pwd`

# create directories
mkdir -p data
mkdir -p data/logs

# set permissions
chmod -R o+w data/logs
chcon -R -t httpd_sys_rw_content_t data/logs

# generate config files
(
cd config/
for DEFAULTS_FILE in `ls *.defaults`
do
    INI_FILE=`basename ${DEFAULTS_FILE} .defaults`
    if [ ! -f ${INI_FILE} ]
    then
        cat ${DEFAULTS_FILE} | sed "s|/PATH/TO/APP|${INSTALL_DIR}|g" > ${INI_FILE}
    fi
done
)

# httpd configuration
echo "***********************"
echo "* HTTPD Configuration *"
echo "***********************"
echo "---- cut ----"
cat docs/apache.conf | sed "s|/PATH/TO/APP|${INSTALL_DIR}|g" | sed "s|APPNAME|${APP_NAME}|g"
echo "---- cut ----"
