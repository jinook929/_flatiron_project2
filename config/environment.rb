require 'bundler'
bundler.require

set(:databasse, {adapter: "sqlite3", database: "vlogdata.db"})

require_all 'app'