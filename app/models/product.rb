class Product < ApplicationRecord
  filterrific :default_filter_params => { :sorted_by => 'created_at_desc' },
                :available_filters => [
                  :sorted_by,
                  :search_query,
                  :with_min_price,
                  :with_max_price,
                  :with_category_id,
                  :with_brand_id,
                  :with_created_at_gte
                ]

    # default for will_paginate
    self.per_page = 9

    belongs_to :category
    belongs_to :brand
    #has_many :picture, dependent: :destroy
    # tell the model to accept the nested attributes for attached_assets
    #accepts_nested_attributes_for :picture
    # CarrierWave
    has_many :pictures, dependent: :destroy
    
    #accepts_nested_attributes_for :pictures

    # mount_uploader :image, ImageUploader
    # has_many :image, dependent: :destroy
    #accepts_nested_attributes_for :pictures
    # has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
    # validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

    scope :search_query, lambda { |query|
      return nil  if query.blank?
      # condition query, parse into individual keywords
      terms = query.downcase.split(/\s+/)
      # replace "*" with "%" for wildcard searches,
      # append '%', remove duplicate '%'s
      terms = terms.map { |e|
        (e.gsub('*', '%') + '%').gsub(/%+/, '%')
      }
      # configure number of OR conditions for provision
      # of interpolation arguments. Adjust this if you
      # change the number of OR conditions.
      num_or_conditions = 3
      where(
        terms.map {
          or_clauses = [
            "LOWER(products.name) LIKE ?",
            "LOWER(products.name) LIKE ?",
            "LOWER(products.description) LIKE ?"
          ].join(' OR ')
          "(#{ or_clauses })"
        }.join(' AND '),
        *terms.map { |e| [e] * num_or_conditions }.flatten
      )
    }
    scope :with_min_price, lambda { |min_price|
      where('products.price >= ?', min_price)
    }
    scope :with_max_price, lambda { |max_price|
      where('products.price <= ?', max_price)
    }
    scope :sorted_by, lambda { |sort_option|
      # extract the sort direction from the param value.
      direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
      case sort_option.to_s
      when /^created_at_/
        order("products.created_at #{ direction }")
      when /^price_/
        order("products.price #{ direction }")
      when /^name_/
        order("LOWER(products.name) #{ direction }")
      else
        raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
      end
    }
    
    scope :with_category_id, lambda { |category_ids|
      where(:category_id => [*category_ids])
    }
    scope :with_brand_id, lambda { |brand_ids|
      where(:brand_id => [*brand_ids])
    }
    scope :with_created_at_gte, lambda { |ref_date|
      where('products.created_at >= ?', ref_date)
    }

    delegate :name, :to => :category, :prefix => true
    delegate :name, :to => :brand, :prefix => true

    def self.options_for_sorted_by
      [
        ['Registration date (newest first)', 'created_at_desc'],
        ['Registration date (oldest first)', 'created_at_asc'],
        ['Price (low to high)', 'price_asc'],
        ['Price (high to low)', 'price_desc'],
        ['Name (a-z)', 'name_asc']
      ]
    end

    # def full_name
    #   [last_name, first_name].compact.join(', ')
    # end

    def decorated_created_at
      created_at.to_date.to_s(:long)
    end

end
