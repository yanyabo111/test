class Download < ApplicationRecord
  belongs_to :movie
  enum category: %i[迅雷 BT]
end
