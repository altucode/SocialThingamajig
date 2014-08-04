class Circle < ActiveRecord::Base
  validates :owner, presence: true
  validates :name, presence: true, length: { minimum: 2 }

  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :owner_id,
    primary_key: :id,
    inverse_of: :owned_circles
  )

  has_many :circle_memberships, inverse_of: :circle, dependent: :destroy
  has_many :users, through: :circle_memberships, source: :user


  has_many :post_shares, inverse_of: :circle, dependent: :destroy
  has_many :posts, through: :post_shares, source: :post
end
