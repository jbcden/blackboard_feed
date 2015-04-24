#!/usr/bin/env ruby

class Parser
  FEED_FILES_PATH = "/home/jchae/feed/"

  def self.parse_headers(file)
    raw = %x{ head -1 #{FEED_FILES_PATH}#{file} }
    parse_header(raw)
  end

  def self.parse_header(header)
    headers = header.split("|")
    headers.map { |h|
      h.strip!
      h.chomp!
      h.downcase!
    }
  end

  def self.parse_file(lines, db_name)
    insert_string = ""
    lines.each do |line|
      insert_string << "insert into #{db_name} values ("
      line.split("|").each do |element|
        element.chomp!
        insert_string << "'" << element.gsub(/'/,"\\'") << "'" << ","
      end
      insert_string << ")"
    end
    insert_string.gsub!(/,\)/, "); ")
  end
end
