Сборка:
sudo apt-get install sqlite3 libsqlite3-dev
bundle
bundle exec rspec --init
- добавить нв самом верху spec/spec_helper.rb :
  ENV['RACK_ENV'] = 'test'
- добавить вверху config.ru задачу для rack
  require_relative 'app/api'
  run ExpenseTracker::API.new
  можно запустить сервер
  bundle exec rackup
  и выполнить запрос
  curl localhost:9292/expenses/2017-06-10 -w "\n"
Настройка юнит тестов:
  в spec_helper
  убрать begin-end
  закоментировать config.warnings = true и config.profile_examples = 10
  добавить внутри RSpec.configure
Прикручивание базы данных sqlite3:
  в /config/sequel.rb прописываем создание db/test.db или db/production.db
в завизимости от переменной:
  require 'sequel'
  DB = Sequel.sqlite("./db/#{ENV.fetch('RACK_ENV', 'development')}.db")
  пример миграции /db/migrations/0001_create_expenses.rb:
  Sequel.migration do
    change do
      create_table :expenses do
        primary_key :id
        String :payee
        Float :amount
        Date :date
      end
    end
  end
  Запуск миграции для дев дб:
  bundle exec sequel -m ./db/migrations sqlite://db/development.db --echo
  Конфинурирование ДБ для тестов:
  в spec/support/db.rb
  RSpec.configure do |c|
    c.before(:suite) do # хук запуска перед каждым тестом
      Sequel.extension :migration
      Sequel::Migrator.run(DB, 'db/migrations') # создает миграцию
      DB[:expenses].truncate # чистит
    end
  end
  подключить в файле теста:
  require_relative '../../../config/sequel'
  require_relative '../../support/db'
