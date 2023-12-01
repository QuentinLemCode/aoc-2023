require 'uri'
require 'net/http'
require 'dotenv'

Dotenv.load('cookie.env')

def get_input(day)
    uri = URI("https://adventofcode.com/2023/day/#{day}/input")
    Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        request = Net::HTTP::Get.new uri
        request['Cookie'] = ENV['AOC_COOKIE']
        response = http.request request
        response.body
    end
end