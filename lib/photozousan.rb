require "photozousan/version"
require "photozousan/client"
require 'io/console'

module Photozousan
  def download_all_images(album_id, limit=100)
    puts 'your photozou id?:'
    id = gets.chop.to_s
    puts 'your photozou password?:'
    pass = STDIN.noecho(&:gets)
    Client.new(id, pass).dowmload_all_images(album_id, limit)
  end
end
