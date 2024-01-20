#!/bin/bash
# Установка CloudWatch, Postgres 15 и AWS SSM
#sudo yum update -y
#sudo yum install -y amazon-cloudwatch-agent
#sudo amazon-linux-extras install postgresql15
#sudo yum install -y amazon-ssm-agent
#sudo systemctl enable amazon-ssm-agent

# Обновленный скрипт для установки CloudWatch, Postgres 15 и AWS SSM с обработкой ошибок

set -Eeuo pipefail
# Эта команда устанавливает строгий режим обработки ошибок.
# -E наследует обработчик ошибок в функциях,
# -e завершает выполнение при встрече ошибки,
# -u рассматривает неустановленные переменные как ошибку,
# -o pipefail возвращает код ошибки всего pipeline.

trap 'catch $? $LINENO' EXIT
# Этот trap вызывает функцию catch при выходе из скрипта с ошибкой.

catch() {
  if [ "$1" != "0" ]; then
    # Если скрипт завершился с ошибкой, выводится сообщение.
    echo "Ошибка $1 возникла на $2 строке."
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
      echo "Архитектура $ARCH не поддерживается."
      exit 1
      ;;
  esac

  TMP_FILE=$(mktemp)
  curl "$PLUGIN_URL" -o "$TMP_FILE"
  sudo yum install -y "$TMP_FILE"
  rm -f "$TMP_FILE"

  if ! session-manager-plugin; then
    echo "Ошибка при проверке установки плагина SSM."
    exit 1
  fi
}

# Обновление системы
sudo yum update -y

# Вызов функций установки
install_cloudwatch
install_postgres
install_aws_ssm

echo "Установка завершена успешно."
