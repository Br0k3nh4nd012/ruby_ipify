Gem::Specification.new do |s|
    s.name = "ruby_ipify"
    s.version = "0.0.1"
    s.summary = "Ipify in ruby"
    s.description = "A Ruby gem to use ipify which is a simple public IP address API."
    s.authors = ["Gokulakrishnan"]
    s.email = "gokulakrishnan312@gmail.com"
    s.files = Dir['lib/**/*.rb'] + Dir['specs/**/*.rb']
    s.homepage = "https://rubygems.org/gems/ruby_ipify"
    s.license = "MIT"

    s.add_development_dependency 'rspec'
end