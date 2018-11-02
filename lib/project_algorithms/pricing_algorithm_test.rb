module ProjectAlgorithms
  module PricingAlgorithm
    RATINGS = {
        'high': 1.1,
        'low': 0.9,
        'else': 1
    }.freeze
    PRICES = {
        '15':   0.75,
        '25':   0.775,
        '50':   0.8,
        '75':   0.825,
        '100':  0.85,
        '200':  0.875,
        '400':  0.9,
        '600':  0.925,
        'over': 0.95
    }.freeze

    def self.included(klass)
      generate_pricing_methods
    end

    def self.generate_pricing_methods
      RATINGS.each do |rate_key, rate_value|
        PRICES.each do |price, value|
          define_method("calculate_#{rate_key}_#{price}") do |price_reference, product_database|
            (price_reference - product_database['shipping_cost'] * value) * rate_value
          end
        end
      end
    end

    def calculate_price(brand, price_reference, product_database)
      keys = PRICES.keys
      index = keys[0...-1].index{|price| price.to_s.to_i > price_reference} || -1
      rating = RATINGS.keys.index(brand['rating'].to_sym) || -1
      send("calculate_#{RATINGS.keys[rating]}_#{PRICES.keys[index]}", price_reference, product_database)
    end
  end
end


# A class for test
class T
  include ProjectAlgorithms::PricingAlgorithm
  def t
    calculate_price({'rating' => 'low'}, 1000, {'shipping_cost' => 50})
  end
end
puts T.new.t
