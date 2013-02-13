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
