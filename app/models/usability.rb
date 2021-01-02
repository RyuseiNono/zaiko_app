class Usability < ActiveHash::Base
  include ActiveHash::Associations
  has_many :shops

  self.data = [
    # { id: 1, name: '--' },
    { id: 2, name: '可' },
    { id: 3, name: '不可' }
  ]
end
