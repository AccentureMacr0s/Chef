# recipes/postgresql.rb
# Установка и запуск PostgreSQL

# Предполагается, что 'amazon-linux-extras' уже предустановлен в Amazon Linux 2
  execute 'Enable PostgreSQL 15 Repository' do
    command 'amazon-linux-extras enable postgresql15'
    not_if 'amazon-linux-extras | grep postgresql15 | grep enabled'
  end
  
  package 'postgresql-server' do
    action :install
  end
  
  # Инициализация базы данных и запуск сервера
  execute 'Initialize PostgreSQL Database' do
    command 'postgresql-setup initdb'
    not_if { ::File.exist?('/var/lib/pgsql/15/data/pg_hba.conf') }
  end
  
  service 'postgresql' do
    action [:enable, :start]
  end
  
  # Дополнительные настройки для пользователя и базы данных могут быть добавлены здесь
  