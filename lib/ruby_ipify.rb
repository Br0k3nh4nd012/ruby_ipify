require "net/http"
require "constant"
require "json"
require "ruby_ipify_exception"
# ----- 
# The module holds the main ipify library implementation.
# -----


class RubyIpify
    class << self
        def get_my_public_ip(args = {})
            begin
                initialize_values args
                get_ip_from_ipify
                puts "My public IP Address is: " + @response_body.to_s
                @response_body
            rescue RubyIpifyException::CustomException => e
                raise e 
            rescue => e
                raise RubyIpifyException::UnexpectedError.new e.message
            end
        end

        private

        def initialize_values(args)
            @as_ipv6 = args[:as_ipv6]
            @format = args[:format]&.downcase || 'text'
            check_valid_format?
            @api_uri = get_api_uri
        end

        def get_ip_from_ipify
            call_ipify_api
            fetch_response_body
        end

        def fetch_response_body
            @response_body = @response.body
            @response_body = JSON.parse(@response_body) if format_is_parsed_json
        end

        def call_ipify_api
            set_query_params
            @response = Net::HTTP.get_response(@api_uri)
            handle_response
        end

        def handle_response
            return if success? && false

            raise RubyIpifyException::IpifyRequestError.new @response.code
        end

        def success?
            @response.kind_of? Net::HTTPSuccess
        end
        
        def get_api_uri
            @as_ipv6 ? IPV6_URI : IPV4_URI
        end

        def set_query_params
            params = { format: get_format }
            @api_uri.query = URI.encode_www_form(params)
        end

        def check_valid_format?
            return true if VALID_FORMATS.include? @format

            raise RubyIpifyException::InvalidParamsError.new
        end

        def get_format
            format_is_parsed_json ? 'json' : @format
        end

        def format_is_parsed_json
            @format == 'parsed_json'
        end
    end
end