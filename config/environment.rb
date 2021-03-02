require 'bundler'
Bundler.require

require_all 'app'

set(:database, {adapter: "sqlite3", database: "db/vlogdata.db"})
############################################
# ActiveRecord::Base.establish_connection ({
#   adapter: "sqlite3", 
#   database: "db/database.db"
# })
############################################
