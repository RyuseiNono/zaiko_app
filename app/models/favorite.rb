class Favorite < ApplicationRecord
  belongs_to :admin, required: false
  belongs_to :user, required: false
  belongs_to :shop

  with_options presence: true do
    validates :shop_id
  end
  validates_uniqueness_of :shop_id, scope: :user_id, if: :user_id
  validates_uniqueness_of :shop_id, scope: :admin_id, if: :admin_id
  validates :user_id, presence: true, unless: :admin_id?
  validates :admin_id, presence: true, unless: :user_id?
end
