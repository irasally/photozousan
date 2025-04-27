require "photozousan/version"
require "photozousan/client"
require 'io/console'

module Photozousan
  def self.run(id, pass, album_id, limit)
    if album_id.nil?
      print 'donwload photozou-album id?:'
      album_id = gets.to_i
    end

    if limit.nil?
      print 'donwload image limit?(1-1000):'
      limit = gets.to_i
    end

    if id.nil?
      print 'your photozou id?:'
      id = gets.chomp
    end

    if pass.nil?
      print 'your photozou password?:'
      pass = STDIN.noecho(&:gets).chomp
    end

    Client.new(id, pass).dowmload_all_images(album_id, limit)
  end
end

if __FILE__ == $0
  id = nil
  pass = nil
  album_id = nil
  limit = nil
  Photozousan.run(id, pass, album_id, limit)
end
