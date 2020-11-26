# frozen_string_literal: true

class BaseUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  require "openssl"
  require "base64"

  storage :file

  def store_dir
    "storage/#{model.class.base_class.name.underscore}/#{model.id}"
  end

  def filename
    "#{mounted_as}-#{md5}#{File.extname(original_filename)}" if original_filename.present?
  end

  def md5
    chunk = model.send(mounted_as)
    begin
      @md5 ||= Digest::MD5.hexdigest(chunk.read.to_s)
    rescue StandardError => err
      new_logger = Logger.new('log/exceptions.log')
      new_logger.level = Logger::ERROR
      new_logger.error(err.message)
    end
    @md5
  end

  def url
    "#{Rails.application.config.asset_host}#{super}"
  end

  def set_color(field_name)
    manipulate! do |source|
      pixels = source.get_pixels.inject { |arr, arr2| arr.concat(arr2) }
      sum_pixel = pixels.each_with_object([0, 0, 0]) do |pixel, result|
        result[0] += pixel[0]
        result[1] += pixel[1]
        result[2] += pixel[2]
      end
      avg_pixel = []
      avg_pixel[0] = sum_pixel[0] / pixels.length
      avg_pixel[1] = sum_pixel[1] / pixels.length
      avg_pixel[2] = sum_pixel[2] / pixels.length
      hex_color = Color::RGB.from_fraction(avg_pixel[0].to_f / 255, avg_pixel[1].to_f / 255, avg_pixel[2].to_f / 255).hex
      model.send(field_name + '=', "##{hex_color}")
      source
    end
  end

  def img_proxy_url(params = {})
      return nil if !present?
      key = [ENV['IMGPROXY_KEY']].pack("H*")
      salt = [ENV['IMGPROXY_SALT']].pack("H*")

      if Rails.env.development?
        relative_path = path.gsub( Rails.root.to_s, '')
      else
        relative_path = path.match(/releases\/\d*(?<path>.*)/)[:path]
      end
      encoded_url = Base64.urlsafe_encode64("local:#{relative_path}").tr("=", "").scan(/.{1,16}/).join("/")

      resize_type = params[:resize_type] || "auto"
      width = params[:width] || 300
      height = params[:height]
      # gravity = params[:gravity] || "no"
      enlarge = params[:enlarge] || 0
      extend = params[:extend] || 0
      extension = params[:extansion] || "jpg"
      dpr = params[:dpr] || 1
      quality = params[:q] || 80

      rs = ['rs', resize_type, width, height, enlarge, extend].compact.join(':')
      proxy_path = "#{rs}/dpr:#{dpr}/q:#{quality}/#{encoded_url}.#{extension}"

      digest = OpenSSL::Digest.new("sha256")

      hmac = Base64.urlsafe_encode64(OpenSSL::HMAC.digest(digest, key, "#{salt}/#{proxy_path}")).tr("=", "")
      "#{Rails.application.config.asset_host}/images/#{hmac}/#{proxy_path}"
  end
end
