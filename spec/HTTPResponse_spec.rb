require '/home/charles/Documents/ruby/server_http_object/HTTP/HTTPResponse.rb'
require 'socket'

describe HTTPResponse do
	before(:each) do
		@res = HTTPResponse.new
	end

	describe "#header" do
		before(:each) do
			@res.header = { 'k1' => 'v1', 'k2' => 'v2' }
		end

		it "header should return an Array" do
			@res.header.should be_a Hash
		end

		it "header should return k1=>v1, k2=>v2" do
			@res.header.should == { 'k1' => 'v1', 'k2' => 'v2' }
		end			
	end

	describe "#body" do
		before(:each) do
			@res.body = 'body'
		end

		it "body should return a String" do
			@res.body.should be_a String
		end

		it "body should return \'body\'" do
			@res.body.should == 'body'
		end
	end

	 describe "#code" do
                before(:each) do
                        @res.code = '200 GET HTTP/1.1'
                end

                it "body should return a String" do
                        @res.code.should be_a String
                end

                it "body should return \'200 GET HTTP/1.1\'" do
                        @res.code.should == '200 GET HTTP/1.1'
                end
        end

	describe "#send" do
		before(:each) do
			@res.code = '200 HTTP/1.1 ok'
			@res.header = { 'Content-Length' => '4'}
			@res.body = 'body'
		end

		it "the write methode should be used by send methode" do
			socket_double = double(TCPSocket)
			socket_double.should_receive(:write).with("200 HTTP/1.1 ok\nContent-Length: 4\n\nbody")
			@res.send(socket_double)						
		end
	end

	describe "#to_s" do
		before(:each) do
			@res.code = '200 HTTP/1.1 ok'
			@res.header = { 'Content-Length' => '4' }
			@res.body = 'body'
		end

		it "to_s should return a String" do
			@res.to_s.should be_a String
		end

		it "to_s should return HTTP request format" do
			@res.to_s.should == "200 HTTP/1.1 ok\nContent-Length: 4\n\nbody"
		end
	end
end
