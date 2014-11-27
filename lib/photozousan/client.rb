module Photozousan
  class Client
    require 'open-uri'
    require 'openssl'
    require 'json'
    require "fileutils"
    @certs = []
    @base_dir = nil

    def initialize(id, pass)
      @certs = [id, pass]
      @base_dir = "Original_#{Time.now.strftime("%Y%m%d%H%M%S")}"
      FileUtils.mkdir_p(@base_dir)
    end

    def dowmload_all_images(album_id, limit)
      download(get_all_photos(album_id, limit))
    end

    private
    def download(result)
      print 'start download.....'
      result["info"]["photo"].each do |photo|
        img_uri = URI.parse(photo["original_image_url"])
        id = photo["photo_id"]
        File.binwrite("#{@base_dir}/#{id}.jpg", open(img_uri, {:http_basic_authentication => @certs}).read)
        print '.'
      end
      puts 'finished.'
    end

    def get_all_photos(album_id, limit)
      print "\ngetting all image-urls...."
      uri = URI.parse('https://api.photozou.jp/rest/photo_album_photo.json')
      q = {:album_id => album_id, :limit => limit}
      query = URI.escape( q.map{|k, v| "#{k}=#{v}"}.join('&') )
      result = open("#{uri}?#{query}", {:http_basic_authentication => @certs, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE}).read
      puts 'success!'
      JSON.parse result
    end
  end
end
