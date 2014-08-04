class User < ActiveRecord::Base
  attr_reader :password, :password_confirm

  validates :email, presence: true, uniqueness: true
  validates :password_digest, presence: { message: "Password can't be blank" }
  validates :password, length: { minimum: 6, allow_nil: true }
  validates :session_token, presence: true
  validate confirm_password?: { message: "Passwords do not match" }

  after_initialize :ensure_session_token

  has_many(
  :owned_circles,
  class_name: "Circle",
  inverse_of: :owner,
  dependent: :destroy
  )

  has_many :circle_memberships, inverse_of: :user, dependent: :destroy
  has_many :circles, through: :circle_memberships, source: :circle

  has_many :posts, inverse_of: :user, dependent: :destroy

  has_many :shared_posts, through: :circles, source: :posts

  def confirm_password?
    self.errors[:password] << "Passwords do not match" if @password != @password_confirm
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def password_confirm=(confirm)
    @password_confirm = confirm
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by email: email
    return nil if user.nil?
    user.is_password?(password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save!
    self.session_token
  end

  private
  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end
end
