require "ruby_feed/version"
require "ruby_feed/sql_generator"
require "ruby_feed/table_migrator"
require "ruby_feed/parser"

module RubyFeed
  class Feed
    DATABASES = {current: "current", yesterday: "yesterday", two_days_ago: "2_days_ago"}

    def self.setup
      TableMigrator.create_current(DATABASES[:current])
      TableMigrator.create_current(DATABASES[:yesterday])
      TableMigrator.create_current(DATABASES[:two_days_ago])
    end

    def self.update
      TableMigrator.drop_and_recreate(DATABASES[:two_days_ago], DATABASES[:yesterday])
      TableMigrator.drop_and_recreate(DATABASES[:yesterday], DATABASES[:current])
      TableMigrator.create_current(DATABASES[:current])
    end
  end
end
