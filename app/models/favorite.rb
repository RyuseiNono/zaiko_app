class Favorite < ApplicationRecord
  belongs_to :admin, required: false
  belongs_to :user,  required: false
  belongs_to :shop

  validates_uniqueness_of :shop_id, scope: :user_id, if: :user_signed_in?
  validates_uniqueness_of :shop_id, scope: :admin_id, if: :admin_signed_in?

  def user_signed_in?
    user_id != nil
  end

  def admin_signed_in?
    admin_id != nil
  end
end
