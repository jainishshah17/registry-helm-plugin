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

function config {
    $HELM_PLUGIN_DIR/jfrog rt config --url $1 --user $2 --apikey $3 --interactive false
}

function print {
    $HELM_PLUGIN_DIR/jfrog -v
}

function push {
    $HELM_PLUGIN_DIR/jfrog rt u "$1" $2
}

[ -z "$HELM_PLUGIN_DIR" ] && HELM_PLUGIN_DIR="$HOME/.helm/plugins/registry-helm-plugin"

if [ ! -e "$HELM_PLUGIN_DIR/jfrog" ]; then
    cd $HELM_PLUGIN_DIR
    curl -fL https://getcli.jfrog.io | sh
fi

case "$1" in
  list-plugin-versions)
    list_plugin_versions
    ;;
  config)
    config "${@:2}"
    ;;
  push)
    push "${@:2}"
    ;;
  *)
    print
    ;;
esac