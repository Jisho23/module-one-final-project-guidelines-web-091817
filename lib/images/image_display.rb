class Images
  def self.wrong
    Catpix::print_image "pokemon.png",
    :limit_x => 1.0,
    :limit_y => 0,
    :center_x => true,
    :center_y => true,
    :bg => "white",
    :bg_fill => false
  end

  def self.badass
  end

  def self.treestar
  end

  def self.dense
  end
end
