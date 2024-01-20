#!/bin/bash
set -Eeuo pipefail

trap 'catch $? $LINENO' EXIT

catch() {
  if [ "$1" != "0" ]; then
    echo "Error $1 occurred on $2 line."
    exit $1
  fi
}

install_cloudwatch() {
  sudo yum install -y amazon-cloudwatch-agent
  sudo systemctl enable amazon-cloudwatch-agent
  sudo systemctl start amazon-cloudwatch-agent
}

install_postgres() {
  sudo amazon-linux-extras install -y postgresql15
  sudo systemctl enable postgresql
  sudo systemctl start postgresql
}

install_aws_ssm() {
  ARCH=$(uname -m)
  case $ARCH in
    x86_64)
      PLUGIN_URL="https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm"
      ;;
    aarch64)
      PLUGIN_URL="https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_arm64/session-manager-plugin.rpm"
      ;;
    *)
      echo "Architecture $ARCH is not supported."
      exit 1
      ;;
  esac

  TMP_FILE=$(mktemp)
  curl "$PLUGIN_URL" -o "$TMP_FILE"
  sudo yum install -y "$TMP_FILE"
  rm -f "$TMP_FILE"

  if ! session-manager-plugin; then
    echo "SSM plugin installation check failed."
    exit 1
  fi
}

main() {
  sudo yum update -y
  install_cloudwatch
  install_postgres
  install_aws_ssm
  echo "Installation completed successfully."
}
