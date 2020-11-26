class BaseSerializer < ActiveModel::Serializer

  def meta
    {
      title: object.meta_title,
      description: object.meta_description,
      keywords: object.meta_keywords
    }
  end

  def image_set(image, params = {})
    return [] if !image.present?
    dprs = params.delete(:dprs) || [1,2]
    dprs.map do |dpr|
      {
        dpr: dpr,
        src: image.img_proxy_url(params.merge(dpr: dpr))
      }
    end
  end

  def admin_url
    object.admin_url if admin_can
  end

  def admin_can
    instance_options[:admin_can]
  end

end
