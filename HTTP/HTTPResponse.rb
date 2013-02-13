require '/home/charles/Documents/ruby/server_http_object/HTTP/http'

class HTTPResponse < HTTP

	def initialize
		super
	end

	def send(socket)
		response = String.new
		response = "#{code}\n"

		@header.each do |el|
			response += "#{el.join(': ')}\n"
		end
		response += "\n#{body}"

		socket.write(response)
	end
end
