class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  with_options presence: true do
    validates :name
    with_options format: { with: /\A(?=.*?[a-z])[a-z\d]+\z/i } do
      validates :password
    end
  end
end
