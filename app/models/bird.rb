class Bird < ApplicationRecord
  belongs_to :node, inverse_of: :birds
end
