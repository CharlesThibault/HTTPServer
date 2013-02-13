module HTTP

	class HTTP
		attr_accessor :header, :body, :code

		def initialize
			@code = ""
			@header = {}
			@body = ""
		end

		def to_s
			req = "#{@code}\n"
			@header.each do |k, v|
				req += "#{k}: #{v}\n"
			end
			req += "\n#{@body}"
		end
	end

	class Request < HTTP

		def initialize(socket)
			super()
			parse_request(socket)
		end

		def parse_request(socket) 
			# get first line
			@code = socket.gets.chomp
			#get header
			until (s = socket.gets.chomp).empty?				
				k,v = s.split(": ")
				@header[k] = v
			end 

			#get body
		         unless @header["Content-Length"].nil?
		         	@body = socket.read(@header["Content-Length"].to_i)
		        end
		end
	end

	class Response < HTTP

		def initialize
			super
		end
	end
end
