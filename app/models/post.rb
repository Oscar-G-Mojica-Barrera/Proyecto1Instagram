class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  validates :image, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  #mount_uploader :image, ImageUploader # Si usas CarrierWave

  # Método para redimensionar la imagen
  #after_save :resize_image

  def resize_image
    return unless image.present?

    # Cargar la imagen usando MiniMagick
    img = MiniMagick::Image.open(image.path)

    # Redimensionar la imagen a 600x600
    img.resize "600x600"

    # Guardar la imagen redimensionada
    img.write(image.path)
  end
 
  private
  #def resize_image
  #  return unless image.attached?

   # image.variant(resize_to_fill: [600, 600]).processed
 # end

end
