require '../HTTP/http'
require 'socket'

describe HTTP::Response do
	before(:each) do
		@res = HTTP::Response.new
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

	describe "#write" do
		it "write should add content to the request\'body" do
			@res.write 'test write'
			@res.body.should == 'test write'
		end 
	end

	describe "#code_message" do
		before(:each) do
                        @res.code_message = 'ok'
                end

                it "message should return a String" do
                        @res.code_message.should be_a String
                end

                it "message should return \'ok\'" do
                        @res.code_message.should == 'ok'
                end
	end

	 describe "#code" do
                before(:each) do
                        @res.code = '200 HTTP/1.1 ok'
                end

                it "body should return a String" do
                        @res.code.should be_a String
                end

                it "body should return \'200 HTTP/1.1 ok\'" do
                        @res.code.should == '200 HTTP/1.1 ok'
                end
        end

	describe "#to_s" do
		before(:each) do
			@res.code = '200'
			@res.code_message = 'ok'
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
