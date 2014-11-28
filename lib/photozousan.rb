require "photozousan/version"
require "photozousan/client"
require 'io/console'

module Photozousan
  def self.run
    print 'donwload photozou-album id?:'
    album_id = gets.to_i
    print 'donwload image limit?(1-1000):'
    limit = gets.to_i
    print 'your photozou id?:'
    id = gets.chomp
    print 'your photozou password?:'
    pass = STDIN.noecho(&:gets).chomp
    Client.new(id, pass).dowmload_all_images(album_id, limit)
  end
end
