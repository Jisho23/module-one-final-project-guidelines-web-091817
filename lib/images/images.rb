require 'tco'
require 'rmagick'
require 'catpix'

#http://www.rubydoc.info/github/pazdera/catpix/master/Catpix.print_image has a list of what the hell the catpix symbols do.

class Image

  def self.tree_stars
    Catpix::print_image "./lib/images/dVgfr.jpg",
  :limit_x => 0.5,
  :limit_y => 0.5
  # :center_x => true,
  # :center_y => true,
  # :bg => "white",
  # :bg_fill => true
  end

end
