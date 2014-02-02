class Image < ActiveRecord::Base
  validates_uniqueness_of :image_id
  validates_presence_of :extension

  before_validation :generate_id

  def path!
    # return the image's full path from the root ==
    "uploads/" + self.image_id + self.extension
  end

  # from: http://stackoverflow.com/a/12109098
  def generate_id
    self.image_id = loop do
      random_token = SecureRandom.hex(10) # 20 digit long random hex string (hex doubles the input number for length)
      break random_token unless Image.exists?(:image_id => random_token)
    end
  end

end
