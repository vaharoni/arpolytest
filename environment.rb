require 'bundler/setup'
require 'active_record'

ActiveRecord::Base.establish_connection adapter: 'sqlite3', database: File.expand_path('../db/arpolytest.sqlite', __FILE__)

require_relative 'models/post'
require_relative 'models/member_post'
require_relative 'models/guest_post'
require_relative 'models/asset'
