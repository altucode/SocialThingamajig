class Post < ActiveRecord::Base
  validates :user, presence: true

  belongs_to :user, inverse_of: :posts

  has_many :post_shares, inverse_of: :post, dependent: :destroy
  has_many :circles, through: :post_shares, source: :circle

  has_many :links, inverse_of: :post, dependent: :destroy


  def link_urls=(link_urls)
    urls = link_urls.keep_if { |url| !url.empty? }
    self.links = urls.map { |url| Link.new(url: url, post_id: self.id) }
  end
end
