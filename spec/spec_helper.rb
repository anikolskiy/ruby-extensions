require 'rubygems'
require 'bundler/setup'

require 'rspec/rails'

ActiveRecord::Base.establish_connection(
  adapter:  "sqlite3",
  database: "sqlite3.db",
  timeout:  3600
)

ActiveRecord::Migration.class_eval do
  unless ActiveRecord::Base.connection.table_exists? :sanitization_test_models
    create_table :sanitization_test_models do |t|
      t.string :name
      t.text :content
    end
  end
end

RSpec.configure do |config|
  config.order = 'random'
end
