require 'open-uri'
require 'openssl'
require 'json'
require 'fileutils'
require 'pp'

module Photozousan
  class Client
    PHOTO_INFO_URL = "https://api.photozou.jp/rest/photo_info.json?photo_id="
    PHOTO_ALBUM_PHOTO_URL = "https://api.photozou.jp/rest/photo_album_photo.json"

    def initialize(id, pass)
      @certs = [id, pass]
      @base_dir = "Original_#{Time.now.strftime('%Y%m%d%H%M%S')}"
      FileUtils.mkdir_p(@base_dir)
    end

    def dowmload_all_images(album_id, limit)
      download(get_all_photos(album_id, limit))
    end

    private

    def get_original_image_uri(photo_id)
      extInfo_uri = URI.parse(PHOTO_INFO_URL + photo_id.to_s)
      extInfo = JSON.parse(URI.open(extInfo_uri).read)
      original_image_url = extInfo['info']['photo']['original_image_url']
      original_image_uri = URI.parse(original_image_url)
    end

    def download(result)
      print 'start download.....'
      result["info"]["photo"].each do |photo|
        img_uri = URI.parse(photo["original_image_url"])
        id = photo["photo_id"]
        original_image_uri = get_original_image_uri(id)

        File.binwrite(
          File.join(@base_dir, "#{id}.jpg"),
          URI.open(original_image_uri, http_basic_authentication: @certs).read
        )
        print '.'
      end
      puts 'finished.'
    end

    def get_all_photos(album_id, limit)
      print "\ngetting all image-urls...."
      uri = URI.parse(PHOTO_ALBUM_PHOTO_URL)
      query = URI.encode_www_form(album_id: album_id, limit: limit)
      full_uri = URI.parse("#{uri}?#{query}")

      result = URI.open(full_uri,
        http_basic_authentication: @certs,
        ssl_verify_mode: OpenSSL::SSL::VERIFY_NONE
      ).read
      puts 'success!'
      JSON.parse(result)
    end
  end
end
