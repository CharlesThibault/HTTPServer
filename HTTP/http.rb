module HTTP

	class HTTP
		attr_accessor :header, :body

		def initialize
			@code = ""
			@header = {}
			@body = ""
		end

		def to_s
			req = ""
			@header.each do |k, v|
				req += "#{k}: #{v}\n"
			end
			req += "\n#{@body}"
		end
	end

	class Request < HTTP
		attr_accessor :version, :path

		def initialize(socket)
			super()
			@version = ""
			@path = ""
			parse_request(socket)
		end

		def parse_request(socket) 
			if (socket.size != 0 )		
				# get first line
				first_line = socket.gets.chomp
				@action, @path, @version = first_line.split(" ")
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

		def to_s
			s = "#{@action} #{@path} #{@version}\n#{super}"
		end
	end

	class Response < HTTP
		attr_accessor :code_message, :code
		@@version = "HTTP/1.1"

		def initialize
			super
		end

		def write(str)
			@body = str 
		end

		def to_s
			s = "#{code} #{@@version} #{code_message}\n#{super}"
		end
	end
end
