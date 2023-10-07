require 'constant'

module RubyIpifyException

    class CustomException < StandardError
    end

    class IpifyRequestError < CustomException
        def initialize(code='')
            msg = "Received an invalid status code from ipify: #{code}. The service might be experiencing issues."
            super(msg)
        end
    end

    class InvalidParamsError < CustomException
        def initialize
            msg = "Wrong Format value passed. Please pass anyone from [#{VALID_FORMATS.join(', ')}]."
            super(msg)
        end
    end

    class UnexpectedError <CustomException
        def initialize(err_msg='')
            msg = "Unexpected error occured. Failed with an error: #{err_msg}."
            super(msg)
        end
    end
end 