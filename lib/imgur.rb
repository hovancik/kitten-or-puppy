# Connection to imgur API
module Imgur
  class << self
    require 'net/http'
    require 'net/https'
    require 'json'
    require 'dotenv'

    GALLERY_API_PATH = 'https://api.imgur.com/3/gallery/r/'.freeze

    Dotenv.load

    def gallery(subreddit)
      path = GALLERY_API_PATH + subreddit
      response = connect(path)
      if response.code == '200'
        JSON.parse(response.body)['data']
      else
        { 'error' => 'bad imgur, bad... ' }
      end
    end

    def connect(path)
      headers = { 'Authorization' => "Client-ID #{ENV['CLIENT_ID']}" }
      uri = URI.parse(path)
      request, = Net::HTTP::Get.new(path, headers)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.request(request)
    end

    def gallery_images(subreddit)
      gallery(subreddit).keep_if { |x| x['is_album'] == false }
    end
  end
end
