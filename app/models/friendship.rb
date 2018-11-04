class Friendship < ApplicationRecord
  belongs_to :usuario
  # Como no existe un modelo friend, tengo que indicarle a quien corresponde este belongs_to
  belongs_to :friend, required: false, class_name: "Usuario"
  # un registro nueva actividad
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_usuario }
end
