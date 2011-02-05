#!/usr/bin/env ruby
require 'net/http/post/multipart'

url = URI.parse('http://localhost:3000/copy')

io = if ARGF.filename.match(/-/)
  CompositeReadIO.new ARGF
else
  UploadIO.new(ARGF, nil, ARGF.filename)
end

req = Net::HTTP::Post::Multipart.new url.path, 'data' => io
req.basic_auth *ENV['NWCOPY_CREDS'].split(':')

res = Net::HTTP.start(url.host, url.port) do |http|
  http.request req
end

puts res.body
