class Attachment < ApplicationRecord
  belongs_to :post
  # Llamo al concern para que haga la logica de guardar la imagen.
  include Picturable
end
