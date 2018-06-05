class Category < ApplicationRecord
  has_many :products, :dependent => :nullify
  has_many :brands, :dependent => :nullify

    def self.options_for_select
      order('LOWER(name)').map { |e| [e.name, e.id] }
    end

end
