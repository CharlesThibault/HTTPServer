require '/home/charles/Documents/ruby/server_http_object/HTTP/HTTPRequest.rb'

describe HTTPRequest do
	before(:each) do
		@req = HTTPRequest.new
	end

	context "when just created" do
		its(:header) { should be_nil }
		its(:body) { should be_nil }
		its(:code) { should be_nil }
	end

	describe "#header" do
		before(:each) do
			@req.header = { 'k1' => 'v1', 'k2' => 'v2' }
		end

		it "header should return an Array" do
			@req.header.should be_a Hash
		end

		it "header should return k1=>v1, k2=>v2" do
			@req.header.should == { 'k1' => 'v1', 'k2' => 'v2' }
		end			
	end

	describe "#body" do
		before(:each) do
			@req.body = 'body'
		end

		it "body should return a String" do
			@req.body.should be_a String
		end

		it "body should return \'body\'" do
			@req.body.should == 'body'
		end
	end

	 describe "#code" do
                before(:each) do
                        @req.code = '200 GET HTTP/1.1'
                end

                it "body should return a String" do
                        @req.code.should be_a String
                end

                it "body should return \'200 GET HTTP/1.1\'" do
                        @req.code.should == '200 GET HTTP/1.1'
                end
        end

	describe "#parse_request" do
		before(:each) do
			@r = "200 GET HTTP/1.1\nContent-Length: 4\n\nbody"
			@req.parse_request(@r)
		end

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
