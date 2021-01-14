class Favorite < ApplicationRecord
  belongs_to :admin, required: false
  belongs_to :user,  required: false
  belongs_to :shop

  validates_uniqueness_of :shop_id, scope: :user_id, if: :user_id
  validates_uniqueness_of :shop_id, scope: :admin_id, if: :admin_id


end
