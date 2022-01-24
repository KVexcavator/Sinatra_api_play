Сборка:
sudo apt-get install sqlite3 libsqlite3-dev
bundle
bundle exec rspec --init
- to the top of spec/spec_helper.rb :
  ENV['RACK_ENV'] = 'test'
