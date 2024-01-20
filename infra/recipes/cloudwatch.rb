# recipes/cloudwatch.rb
# Установка и запуск агента Amazon CloudWatch

package 'amazon-cloudwatch-agent' do
    action :install
  end
  
  service 'amazon-cloudwatch-agent' do
    action [:enable, :start]
  end
  
  # Для полной настройки может потребоваться создать и разместить соответствующий конфигурационный файл агента CloudWatch
  # и возможно выполнить дополнительные команды для его настройки.
  