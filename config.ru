require_relative 'app/api'
puts "Server is run ..."
run ExpenseTracker::API.new
