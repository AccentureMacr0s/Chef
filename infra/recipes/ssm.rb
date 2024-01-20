# recipes/ssm.rb
# Этот рецепт устанавливает плагин AWS SSM согласно архитектуре системы

ARCH = node['kernel']['machine']

case ARCH
when 'x86_64'
  ssm_plugin_url = "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_64bit/session-manager-plugin.rpm"
when 'aarch64'
  ssm_plugin_url = "https://s3.amazonaws.com/session-manager-downloads/plugin/latest/linux_arm64/session-manager-plugin.rpm"
else
  raise "Архитектура #{ARCH} не поддерживается."
end

remote_file '/tmp/session-manager-plugin.rpm' do
  source ssm_plugin_url
  action :create
end

rpm_package 'session-manager-plugin' do
  source '/tmp/session-manager-plugin.rpm'
  action :install
end

file '/tmp/session-manager-plugin.rpm' do
  action :delete
end
