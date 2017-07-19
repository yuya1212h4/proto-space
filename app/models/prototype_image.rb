class PrototypeImage < ApplicationRecord

  belongs_to :prototype

  enum image_type: { main: 0, sub: 1 }
end
