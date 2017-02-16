class User < ApplicationRecord
  paginates_per 10

  has_many :companies
  has_many :subscribes

  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :validatable

  def role
    self.admin? ? "Administrador" : "Usuário"
  end
end
