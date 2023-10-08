require 'rspec'
require 'ruby_ipify'
require './lib/constant'

describe RubyIpify do
    before(:each) {
        @sample_ipv4 = "1.1.1.1"
        @sample_ipv6 = "240x:40fx:102x:e36x:749x:cabx:2b8x:cb2x"
        @response = Net::HTTPSuccess.new("1.0", '200', 'OK')
        allow(Net::HTTP).to receive(:get_response).and_return(@response)
    }
    
    context 'IPv4' do 
        before { allow(@response).to receive(:body).and_return(@sample_ipv4) }
        it 'triggers api to IPv4 endpoint' do
            expect(Net::HTTP).to receive(:get_response).with(IPV4_URI)
            RubyIpify.get_my_public_ip
        end

        it 'returns IPv4 address' do 
            expect(RubyIpify.get_my_public_ip).to eq(@sample_ipv4)
        end
        
        context 'format as json' do 
            it 'trigger api with format' do 
                expect(Net::HTTP).to receive(:get_response) do |request|
                    expect(request.request_uri).to eq("/?format=json")
                    @response
                end
                RubyIpify.get_my_public_ip(format: 'json')
            end

            it 'returns IPv4 address as json format' do 
                expected_response = { 'ip' => @sample_ipv4 }.to_json
                allow(@response).to receive(:body).and_return(expected_response)
                res = RubyIpify.get_my_public_ip(format: 'json')
                expect(res).to eq expected_response
            end
        end

        context 'format as parsed_json' do 
            it 'trigger api with format' do 
                expect(Net::HTTP).to receive(:get_response) do |request|
                    expect(request.request_uri).to eq("/?format=json")
                    @response
                end
                RubyIpify.get_my_public_ip(format: 'json')
            end

            it 'returns IPv4 address as parsed json format' do 
                expected_response = { 'ip' => @sample_ipv4 }
                allow(@response).to receive(:body).and_return(expected_response.to_json)
                res = RubyIpify.get_my_public_ip(format: 'parsed_json')
                expect(res).to eq expected_response
            end
        end

        context 'wrong format passed' do 
            it 'raise InvalidParamsError exception' do 
                expect{ RubyIpify.get_my_public_ip(format: 'abc') }.to raise_error (RubyIpifyException::InvalidParamsError)
            end
        end
    end 

    context 'IPv6' do 
        before { allow(@response).to receive(:body).and_return(@sample_ipv6) }

        it 'triggers api to IPv4 endpoint' do
            expect(Net::HTTP).to receive(:get_response).with(IPV6_URI)
            RubyIpify.get_my_public_ip(as_ipv6: true)
        end

        it 'returns IPv4 address' do 
            expect(RubyIpify.get_my_public_ip(as_ipv6: true)).to eq(@sample_ipv6)
        end
        
        context 'format as json' do 
            it 'trigger api with format' do 
                expect(Net::HTTP).to receive(:get_response) do |request|
                    expect(request.request_uri).to eq("/?format=json")
                    @response
                end
                RubyIpify.get_my_public_ip(as_ipv6:true, format: 'json')
            end

            it 'returns IPv4 address as json format' do 
                expected_response = { 'ip' => @sample_ipv6 }.to_json
                allow(@response).to receive(:body).and_return(expected_response)
                res = RubyIpify.get_my_public_ip(as_ipv6: true, format: 'json')
                expect(res).to eq expected_response
            end
        end

        context 'format as parsed_json' do 
            it 'trigger api with format' do 
                expect(Net::HTTP).to receive(:get_response) do |request|
                    expect(request.request_uri).to eq("/?format=json")
                    @response
                end
                RubyIpify.get_my_public_ip(as_ipv6: true, format: 'json')
            end

            it 'returns IPv4 address as parsed json format' do 
                expected_response = { 'ip' => @sample_ipv6 }
                allow(@response).to receive(:body).and_return(expected_response.to_json)
                res = RubyIpify.get_my_public_ip(as_ipv6: true, format: 'parsed_json')
                expect(res).to eq expected_response
            end
        end

        context 'wrong format passed' do 
            it 'raise InvalidParamsError exception' do 
                expect{ RubyIpify.get_my_public_ip(format: 'abc') }.to raise_error (RubyIpifyException::InvalidParamsError)
            end
        end
    end 
end