# require 'bundler'
# Bundler.require

require 'bundler/setup'
require "sinatra/activerecord"
Bundler.require

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
ActiveRecord::Base.logger = nil
require_all 'lib'
