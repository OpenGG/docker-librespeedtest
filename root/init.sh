#!/bin/sh
set -e

UID=`id -u`
GID=`id -g`

echo
echo "UID: $UID"
echo "GID: $GID"
echo

echo "Setting conf"

if [[ -f /settings.toml ]]
then
  size=$(stat -c "%s" /settings.toml)

  if [ "${size}" == "0" ]
  then
    echo "Init settings.toml with default values"
    cat /settings.toml.default > /settings.toml
  else
    echo "Use existed settings.toml"
  fi
else
  echo "Create settings.toml with default values"

  cat /settings.toml.default > /settings.toml
fi

echo "[DONE]"

echo "Setting owner and permissions"

touch /speedtest.db
chown -R $UID:$GID /speedtest.db
chmod 644 /speedtest.db

echo "[DONE]"

echo "Starting server"

exec /main \
  > /dev/stdout \
  2 > /dev/stderr

echo 'Exiting server'
