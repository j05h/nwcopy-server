#!/usr/bin/env ruby
require 'net/http'

url = URI.parse("http://localhost:3000/paste")

req = Net::HTTP::Get.new(url.path)
req.basic_auth *ENV['NWCOPY_CREDS'].split(':')

res = Net::HTTP.start(url.host, url.port) do |http|
  http.request(req)
end

file = res['Location'].split('/').last

if file && !File.exists?(file)
  File.open file, 'w+' do |f|
    f << res.body
  end
  puts "Pasted to #{file}"
else
  puts res.body
end

