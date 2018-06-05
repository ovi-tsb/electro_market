class Brand < ApplicationRecord
  has_many :products, :dependent => :nullify
  has_many :categories, through: :products, :dependent => :nullify
  #belongs_to :category
  def self.options_for_select
    order('LOWER(name)').map { |e| [e.name, e.id] }
  end
  
end
