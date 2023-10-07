# Ruby Ipify
**A Gem for which use Ipify [*`<https://www.ipify.org/>`*](https://www.ipify.org/)  service to provide the public IP address. *A Simple Public IP Address API, Likewise a geographical IP address details API*.**


## About ipify
[Ipify](https://www.ipify.org/) is the best IP address lookup service on the internet. It's fast, simple, scalable, open source
Ever needed to get your public IP address programmatically?
Maybe you're provisioning new cloud servers and need to know your IP -- maybe you're behind a corporate firewall and need to tunnel information 
-- whatever the reason: sometimes having a public IP address API is useful!


## Installation
To install, simply run the below command in the bash:
```bash
gem install ruby_ipify
```

## Usage
Using this gem is very simple. Here's a simple example:

###### IP Address API
```ruby
irb(main):001> RubyIpify.get_my_public_ip
=> "127.0.0.1" # returns IPv4

irb(main):013> RubyIpify.get_my_public_ip(format: 'json')
=> "{\"ip\":\"157.46.101.232\"}" # returns as json string

irb(main):012> RubyIpify.get_my_public_ip(format: 'parsed_json')
=> {"ip"=>"157.46.101.232"}  # returns as parsed json

irb(main):002> RubyIpify.get_my_public_ip(as_ipv6: true)
=> "240x:408x:3e8x:edax:6b8x:d52x:6b2x:cb6x" # returns IPv6

irb(main):002> RubyIpify.get_my_public_ip(as_ipv6: true, format: 'json')
=> "{\"ip\":\"240x:408x:3e8x:edax:6b8x:d52x:6b2x:cb6x\"}" 

irb(main):009> RubyIpify.get_my_public_ip(as_ipv6: true, format: 'parsed_json')
=> {"ip"=>"240x:408x:3e8x:edax:6b8x:d52x:6b2x:cb6x"}


# If Ipify API fails to serve, 
irb(main):002> RubyIpify.get_my_public_ip
=> Received an invalid status code from ipify: <ResponseCode>. The service might be experiencing issues. (RubyIpifyException::IpifyRequestError)

# when worng format value is passed in arguments
irb(main):002> RubyIpify.get_my_public_ip(format: "wrong_format")
=> Wrong Format value passed. Please pass anyone from [json, text, parsed_json]. (RubyIpifyException::InvalidParamsError)


# For any code failure issue, 
irb(main):001> RubyIpify.get_my_public_ip
=> "Unexpected error occured. Failed with an error: <ActualError>}."RubyIpifyException::UnexpectedError)
```

