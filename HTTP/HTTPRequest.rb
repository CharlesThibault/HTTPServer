require '/home/charles/Documents/ruby/server_http_object/HTTP/http'

class HTTPRequest < HTTP

	def initialize
		super
	end

	def parse_request(req) 
		@header = {}
		tab = req.split("\n")
		
		tab.each do |el|
			k, v = el.split(': ')
			if v
				@header[k] = v
			end
		end
	end
end
