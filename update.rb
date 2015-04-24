#!/usr/bin/env ruby

require 'sequel'
require_relative './sql_generator'

class ::TableMigrator
  DATABASES = {current: "current", yesterday: "yesterday", two_days_ago: "2_days_ago"}
  FEED_PATH = ENV["FEED_PATH"]

  DATABASE_USER = ENV["DATABASE_USER"]
  DATABASE_PASS = ENV["DATABASE_PASS"]

  def self.update
    drop_and_recreate(DATABASES[:two_days_ago], DATABASES[:yesterday])
    drop_and_recreate(DATABASES[:yesterday], DATABASES[:current])
    create_current(DATABASES[:current])
  end

  def self.create_current(db_name)
    create(db_name)
    create_tables(db_name)
    insert_into(db_name)
  end

  def self.insert_into(db_name)
    db = connect(db_name)
    table_names = get_table_names

    table_names.each do |table|
      table_name = File.basename(table)
      insert_string = Parser.parse_file(File.readlines(table).drop(1), table_name)
      next if insert_string.nil?
      insert_string.split(";").each do |s|
        next if s == " "
        # p s
        db.run(s)
      end
    end
  end

  def self.create_tables(db_name)
    db = connect(db_name)
    table_names = get_table_names

    tables = files.map {|f| File.basename(f, ".*")}
    non_existant_tables = tables.reject { |file| db.table_exists?(File.basename(file)) }

    non_existant_tables.each do |table|
      create_string = SqlGenerator.generate_table_create_string(table)
      # puts create_string
      db.run(create_string)
    end
  end

  def self.migrate_info(to, from)
    drop_and_recreate(to)
    to = connect(to)
    from = connect(from)
  end

  def self.drop_and_recreate(to, from)
    drop(to)
    rename(to, from)
  end

  def self.drop(db_name)
    db = connect
    drop_string = SqlGenerator.generate_drop(db_name)
    db.run(drop_string)
  end

  def self.rename(to, from)
    db = connect
    rename_string = SqlGenerator.generate_rename(to, from)
    db.run(rename_string)
  end

  def self.create(db_name)
    db = connect
    create_string = SqlGenerator.generate_db_create(db_name)
    db.run(create_string)
  end

  private
  def self.connect(db_name="mysql")
    Sequel.connect("mysql2://#{DATABASE_USER}:#{DATABASE_PASS}@localhost/#{db_name}")
  end

  def self.get_table_names
    files = Dir.entries(FEED_PATH) - entries_to_be_excluded_from_db
    files
  end

  def self.entries_to_be_excluded_from_db
    [".", "..", "list"]
  end
end

# ::TableMigrator.insert_into("apples")
