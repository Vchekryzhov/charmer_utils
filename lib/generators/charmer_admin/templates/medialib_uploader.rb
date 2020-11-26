# frozen_string_literal: true

class MedialibUploader  < BaseImageUploader

  def extension_white_list
    %w[jpg jpeg gif png svg]
  end

  version :regular do
    process resize_to_limit: [100, 100]
    process :set_color
  end

  after :cache, :write_size

  def write_size(_file)
    model.width = width
    model.height = height
  end

  def size_range
    1..6.megabytes
  end
end
