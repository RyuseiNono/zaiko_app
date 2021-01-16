class Message < ApplicationRecord
  belongs_to :shop
  belongs_to :user,  required: false
  belongs_to :admin, required: false

  with_options presence: true do
    validates :text
    validates :shop_id
  end
  validates :user_id, presence: true, unless: :admin_id?
  validates :admin_id, presence: true, unless: :user_id?
end
