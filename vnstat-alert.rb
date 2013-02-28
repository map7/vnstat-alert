#!/usr/bin/env ruby
require 'json'

def MB_to_GB(num)
  (num.to_f / 1024).ceil # Round up
end

# Get monthly total
def monthly_used(data)
  data.split.each do |row|
    field = row.split(';')

    if field[0] == "m" and field[1] == "0"
      # Convert to GB
      return MB_to_GB(field[3])
    end
  end
end

def percentage_used(limit, used)
  (used.to_f / limit.to_f * 100).ceil
end

# Read in settings
begin
  serialized = File.read("/etc/vnstat-alert.json")
  data = JSON.parse(serialized)
  limit = data["limit"].to_i
  remote = data["remote"]
rescue
  puts "Please create a /etc/vnstat-alert.json file"
  exit
end

# Get data from vnstat
output = %x[#{remote} vnstat --dumpdb]

used = monthly_used(output)
puts percentage_used(limit, used)





