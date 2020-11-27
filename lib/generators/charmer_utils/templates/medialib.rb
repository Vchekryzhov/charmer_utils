class Medialib < ApplicationRecord
  mount_uploader :image, MedialibUploader

  def update_md5
    update(file_md5: image.md5) if file_md5 != image.md5
  end
end
