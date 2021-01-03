class Parking < ActiveHash::Base
  include ActiveHash::Associations
  has_many :shops

  self.data = [
    { id: 1, name: '有' },
    { id: 2, name: '無' }
  ]
end
