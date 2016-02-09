class Product

	attr_accessor :title, :price, :stock

	@@products = []

	def initialize(options={})
	    @title = options[:title]
		@price = options[:price]
		@stock = options[:stock]
		begin 
			add_to_products
	    rescue StandardError => e
	    	puts e.message
	    end
	end	

	# If no product with a specific title exist
	# push the new product on @@products else raise an 
	# exception
	def add_to_products
		raise DuplicateProductError, "'#{@title}' already exists." if Product.find_by_title(@title)
		@@products << self
	end

	# Return a boolean to indicate if the product is in 
	# stock or not
	def in_stock?
		return @stock != 0 ? true : false
	end

	# All class method

	# Return all products
	def self.all
		@@products 
	end

    # Return a single product based on its title or nil
    # if no product found
    # Params:
    #  +title+: The product title.
	def self.find_by_title(title)
 		@@products.each do |product|
 			return product if product.title == title
		end
		return nil
	end

	# Return an array of all products with a stock greater than zero
	def self.in_stock
		return @@products.select { |product| product.stock != 0}
	end

	# Return and array of all products with a stock under or equal
	# a given threshold
	# Params: 
	#  +threshold+: a specific threshold
	def self.stock_lower_than_or_equal(threshold)
		return @@products.select { |product| product.stock <= threshold}
	end
end