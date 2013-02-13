require '../HTTP/http'
require 'stringio'

describe HTTP::Request do
	before(:each) do
		str = <<REQ
GET http://localhost/toto HTTP/1.1
Content-Length: 4

body
REQ
		req_str = StringIO.new str


		@req = HTTP::Request.new(req_str)
	end

	describe "#header" do
		it "header should return a Hash" do
			@req.header.should be_a Hash
		end

		it "header should be return {\'Content-Length\' => \'4\'" do
			@req.header.should == { 'Content-Length' => '4' }
		end			
	end

	describe "#body" do

		it "body should return a String" do
			@req.body.should be_a String
		end

		it "body should return \'body\'" do
			@req.body.should == 'body'
		end
	end

	 describe "#code" do

                it "body should return a String" do
                        @req.code.should be_a String
                end

                it "body should return \'GET http://localhost/toto HTTP/1.1\'" do
                        @req.code.should == 'GET http://localhost/toto HTTP/1.1'
                end
        end

	describe "#parse_request" do

		it "header should be set" do
			@req.header.should_not be_nil
		end

		it "header should be egal {Content-Length => 4}" do
			@req.header.should == {'Content-Length' => '4'}
		end

	end

	describe "#to_s" do
		before(:each) do
			@req.code = '200 GET HTTP/1.1'
			@req.header = { 'Content-Length' => '4' }
			@req.body = 'body'
		end

		it "to_s should return a String" do
			@req.to_s.should be_a String
		end

		it "to_s should return HTTP request format" do
			@req.to_s.should == "200 GET HTTP/1.1\nContent-Length: 4\n\nbody"
		end
	end
end
