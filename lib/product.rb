class Product

	attr_accessor :title, :price, :stock

	@@products = []

	def initialize(options={})
	    @title = options[:title]
	    # Test if a product already exist
		begin 
			add_to_products
	    rescue StandardError => e
	    	puts e.message
	    end
		@price = options[:price]
		@stock = options[:stock]
	end	



	def add_to_products
		raise DuplicateProductError, "'#{@title}' already exists." if Product.find_by_title(@title)
		@@products << self
	end

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
    # Param:
    #  +title+: The product title.
	def self.find_by_title(title)
 		@@products.each do |product|
 			next if product.title != title
 			return product
		end
		return nil
	end

	# Return an array of all products with a stock greater than zero
	def self.in_stock
		in_stock = []
		# XXX need refactoring
		@@products.each do |product|
			next if product.stock == 0
			in_stock << product 
		end
		return in_stock
	end

end