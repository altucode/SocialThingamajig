class CircleMembership < ActiveRecord::Base
  validates :user, :circle, presence: true

  belongs_to :user, inverse_of: :circle_memberships
  belongs_to :circle, inverse_of: :circle_memberships
end
