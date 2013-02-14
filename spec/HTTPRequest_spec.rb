require '../HTTP/http'
require 'stringio'

describe HTTP::Request do
	before(:each) do
		str = <<REQ
GET http://localhost/toto HTTP/1.1
Content-Length: 4

body
REQ
		@req_str = StringIO.new str			
	end

	describe "#header" do
		it "header should return a Hash" do
			req = HTTP::Request.new(StringIO.new "")
			req.header.should be_a Hash
		end

		it "header should be return {\'Content-Length\' => \'4\'" do
			req = HTTP::Request.new(@req_str)
			req.header.should == { 'Content-Length' => '4' }
		end

		it "header should be empty" do
			req = HTTP::Request.new(StringIO.new "")
			req.header.should be_empty
		end			
	end

	describe "#body" do

		it "body should return a String" do
			req = HTTP::Request.new(StringIO.new "")
			req.body.should be_a String
		end

		it "body should return \'body\'" do
			req = HTTP::Request.new(@req_str)
			req.body.should == 'body'
		end

		it "header should be empty" do
			req = HTTP::Request.new(StringIO.new "")
			req.body.should be_empty
		end
	end

	 describe "#path" do

                it "path should return a String" do
			req = HTTP::Request.new(StringIO.new "")
                        req.path.should be_a String
                end

                it "path should return \'http://localhost/toto\'" do
			req = HTTP::Request.new(@req_str)
                        req.path.should == 'http://localhost/toto'
                end

		it "path should be empty" do
			req = HTTP::Request.new(StringIO.new "")
			req.path.should be_empty
		end
        end

	describe "#version" do

                it "path should return a String" do
			req = HTTP::Request.new(StringIO.new "")
                        req.version.should be_a String
                end

                it "path should return \'HTTP/1.1\'" do
			req = HTTP::Request.new(@req_str)
                        req.version.should == 'HTTP/1.1'
                end

		it "path should be empty" do
			req = HTTP::Request.new(StringIO.new "")
			req.version.should be_empty
		end
        end

	describe "#parse_request" do
		it "size should be called on socket" do
			stringio_double = double(StringIO)
			req = HTTP::Request.new(StringIO.new)
			req.should_receive(:size)	
			req.should_receive(:gets)
			req = HTTP::Request.new(stringio_double)		
		end
	end


	describe "#to_s" do
		before(:each) do
			@req = HTTP::Request.new(@req_str)
		end

		it "to_s should return a String" do
			@req.to_s.should be_a String
		end

		it "to_s should return HTTP request format" do
			@req.to_s.should == "GET http://localhost/toto HTTP/1.1\nContent-Length: 4\n\nbody"
		end
	end

end
