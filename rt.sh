#!/bin/bash
#set -e

function list_plugin_versions {
  if [ -x "$(command -v curl)" ]; then
    local GET="curl -s"
  else
    local GET="wget -q -O -"
  fi
  $GET https://api.github.com/repos/jainishshah17/registry-helm-plugin/tags |grep name | cut -d'"' -f 4
};

function latest {
    list_plugin_versions | head -n 1
}

function print {
    echo "Hello World"
}


case "$1" in
  list-plugin-versions)
    list_plugin_versions
    ;;
  *)
    print
    ;;
esac