require 'socket'
require './HTTP/http.rb'

port = 8080
server = TCPServer.open(port)

class String
  def self.random(size=20)
    set = [('a'..'z'),('A'..'Z')].map{|i| i.to_a}.flatten
    (1..size).map{ set[rand(set.length)] }.join
  end
end

def generate_cookie
  require 'digest/md5'
    Digest::MD5.hexdigest("cooooookiiiie"+String.random)
end

trap('EXIT'){ server.close }

request_number = 0
sessions = {}

loop do
  socket = server.accept

  puts "request No #{request_number += 1}"

  req = HTTP::Request.new(socket)
  res = HTTP::Response.new

  if cookie = req.header["Cookie"] and session_id = cookie.split('=')[1] and sessions[session_id]
    sessions[session_id] << "request No#{request_number} #{req.path}"
    res.write sessions[session_id].join("\n")
  else
    res.header["Set-Cookie"] = "session_id=#{session_id = generate_cookie}"
    sessions[session_id] = ["request No#{request_number} #{req.path}"]
  end
  
  # response
  res.code = "200"
  res.code_message = "ok"
  socket.write res.to_s
  
  socket.close
end

trap('INT') { puts "\nexiting" ; exit }

# Sit back and wait for all child processes to exit.
Process.waitall

