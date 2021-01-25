class Message < ApplicationRecord
  belongs_to :shop
  belongs_to :user, required: false
  belongs_to :admin, required: false

  # 本当はどちらか一方ある方にのみrequiredをかけたいがやり方がわからない

  with_options presence: true do
    validates :text
  end
end
