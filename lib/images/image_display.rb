require 'catpix'
require 'tco'
require 'rmagick'

class Images

  def self.wrong
    Catpix::print_image "./lib/images/lex_luthor.jpg",
    :limit_x => 0.6,
    :limit_y => 0
  end

  def self.badass
    Catpix::print_image "./lib/images/niel.jpg",
    :limit_x => 0.6,
    :limit_y => 0
  end

  def self.treestar
    Catpix::print_image "./lib/images/treestar.jpg",
    :limit_x => 0.6,
    :limit_y => 0
  end

  def self.dense
    Catpix::print_image "./lib/images/dense.jpg",
    :limit_x => 0.6,
    :limit_y => 0
  end
end
