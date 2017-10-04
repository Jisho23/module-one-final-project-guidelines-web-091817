require 'catpix'
require 'tco'
require 'rmagick'

#http://www.rubydoc.info/github/pazdera/catpix/master/Catpix.print_image has a list of what the hell the catpix symbols do.

class Images

  def self.wrong
    Catpix::print_image "./lib/images/lex_luthor.jpg",
    :limit_x => 0.6,
    :limit_y => 0
    # :center_x => true,
    # :center_y => true,
    # :bg => "white",
    # :bg_fill => true
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
