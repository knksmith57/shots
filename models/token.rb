class Token < ActiveRecord::Base
  validates_uniqueness_of :token_id

  after_initialize :init
  before_validation :generate_id

  # set up default parameters
  def init
    self.expires_at = DateTime.now + (60*60*24*365)  # tokens are valid for 1 year
  end

  # from: http://stackoverflow.com/a/12109098
  def generate_id
    self.token_id = loop do
      random_token = SecureRandom.urlsafe_base64(nil, false)
      break random_token unless Token.exists?(:token_id => random_token)
    end
  end

  def is_valid?
    self.expires_at > DateTime.now
  end
end

def token(token_id)
  t = Token.find_by(:token_id => token_id)
  t.try(:valid?) ? t : nil
end
