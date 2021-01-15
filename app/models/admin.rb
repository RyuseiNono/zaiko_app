class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :shops, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_shops, through: :favorites, source: :shop

  with_options presence: true, on: :create do
    validates :name
    with_options format: { with: /\A[a-z0-9]+\z/i } do
      validates :password
    end
  end

  with_options presence: true, on: :update do
    validates :name
  end
end
