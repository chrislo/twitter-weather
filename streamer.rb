require 'rubygems'
require 'tweetstream'
require 'trollop'

options = Trollop::options do
  banner <<-EOS
streamer prints geo-tagged tweets mentioning certain weather-related key words

Usage:
       streamer [options] 
where [options] are:
EOS

  opt :username, "Twitter Username", :type => :string, :required => true
  opt :password, "Twitter Password", :type => :string, :required => true
end

weather_words = %w(weather snow wind rain sun hot cold dry wet)
TweetStream::Client.new(options[:username],options[:password]).track(*weather_words) do |status|
  puts "#{status.geo.coordinates}: #{status.text}" if status.geo
end
