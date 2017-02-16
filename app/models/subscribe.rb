class Subscribe < ApplicationRecord
  belongs_to :user
  belongs_to :company

  validates :plan, presence: true

  STATES = { 0 => "Aberto", 1 => "Pago", 2 => "Vencido" }

  PLANS_PRICE = [["Mensal R$ 49,00/mês", "mensal"],
                 ["Semestral R$ 39,00/mês", "semestral"],
                 ["Anual R$ 29,00/mês", "anual"]]

  def self.waiting
    where.not(state: 1)
  end

  def code
    id.to_s.rjust(5, '0')
  end

  def paid?
    self.state == 1
  end

  def plan_value
    case plan
      when "mensal" then PLANS_PRICE[0][0]
      when "semestral" then PLANS_PRICE[1][0]
      else PLANS_PRICE[2][0]
    end
  end

  def state_value
    STATES[self.state || 0]
  end
end
