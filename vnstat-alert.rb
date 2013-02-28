#!/usr/bin/env ruby
require 'json'

def MB_to_GB(num)
  (num.to_f / 1024).round
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

# Get monthly total
output.split.each do |row|
  field = row.split(';')

  if field[0] == "m" and field[1] == "0"
    # Convert to GB
    used = field[3].to_i / 1024

    # Compare with limit

    # Send email if over 70%
    puts used
  end
end





