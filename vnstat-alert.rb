#!/usr/bin/env ruby
require 'rubygems'
require 'json'
require 'mail'

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

def alert(percent)
  if percent >= 50 && percent < 75
    "Internet usage at 50%"
  elsif percent >= 75 && percent < 90
    "Internet usage at 75%"
  elsif percent >= 90 && percent < 100
    "INTERNET USAGE AT 90% - SLOW DOWN"
  elsif percent >= 100
    "INTERNET EXCEEDED (#{percent}%)"
  end
end

# Read in settings
begin
  serialized = File.read("/etc/vnstat-alert.json")
  data = JSON.parse(serialized)
  limit = data["limit"].to_i
  remote = data["remote"]
  email = data["admin"]
rescue
  puts "Please create a /etc/vnstat-alert.json file"
  exit
end

# Get data from vnstat
output = %x[#{remote} vnstat --dumpdb]

used = monthly_used(output)
puts alert(percentage_used(limit, used))
alert = alert(percentage_used(limit, used))

if alert
  # Email admin
  mail = Mail.new do
    from email
    to email
    subject alert
    body "Notice from vnstat-alert about your internet usage"
  end
  puts mail.to_s
  mail.delivery_method :sendmail
  mail.deliver
end



