#!/usr/bin/env ruby
require_relative './parser'

class SqlGenerator
  def self.generate_table_create_string(table_name)

    create_string = "create table #{table_name} ("
    headers = Parser.parse_headers(table_name)

    headers.each { |header|
      create_string << header << " varchar(255), "
    }

    create_string.sub!(/, $/, "")
    create_string << ")"

    create_string
  end

  def self.generate_drop(db_name)
    "drop database #{db_name}"
  end

  def self.generate_rename(to, from)
    "rename database '#{from}' to '#{to}'"
  end

  def self.generate_db_create(db_name)
    "create database #{db_name}"
  end
end
