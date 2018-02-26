#!/bin/bash
#set -e

function list_plugin_versions {
  if [ -x "$(command -v curl)" ]; then
    local GET="curl -s"
  else
    local GET="wget -q -O -"
  fi
  $GET https://api.github.com/repos/app-registry/appr/tags |grep name | cut -d'"' -f 4
};

function latest {
    list_plugin_versions | head -n 1
}

case "$1" in
  list-plugin-versions)
    list_plugin_versions
    ;;
  *)
    $HELM_PLUGIN_DIR/appr helm $@
    ;;
esac