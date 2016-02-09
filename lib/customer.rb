class Customer
	
	attr_accessor :name

	@@customers = []

	def initialize(options={})
		@name = options[:name]
		begin
			add_to_customers
		rescue StandardError => e
			puts e.message
		end
	end

	# If no customer with a specific name exist
	# push the new customer on @@customers else raise an 
	# exception
	def add_to_customers
		raise DuplicateProductError, "'#{@name}' already exists." if Customer.find_by_name(@name)
		@@customers << self
	end

	# Create a new Transaction for the specific product
	# Params: 
	# +product+: the product for which we want to 
	# create the transaction
	def purchase(product)
		Transaction.new(self,product)
	end

	# All class method

	# Return all customers
	def self.all
		@@customers
	end

    # Return a single customer based on its name or nil
    # if no customer found
    # Params:
    #  +name+: The customer name.
	def self.find_by_name(name)
 		@@customers.each do |customer|
 			return customer if customer.name == name
		end
		return nil
	end

end