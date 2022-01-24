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
