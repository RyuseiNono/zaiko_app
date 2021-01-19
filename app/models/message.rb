class Message < ApplicationRecord
  belongs_to :shop
  belongs_to :user,  required: false
  belongs_to :admin, required: false

  with_options presence: true do
    validates :text
  end
end
