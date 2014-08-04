class PostShare < ActiveRecord::Base
  validates :post, :circle, presence: true

  belongs_to :post, inverse_of: :post_shares
  belongs_to :circle, inverse_of: :post_shares
end
