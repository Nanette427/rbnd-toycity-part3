class Customer
	
	attr_accessor :name

	@@customers = []

	def initialize(options={})
		@name = options[:name]
		# Test if a customer already exist
		begin
			add_to_customers
		rescue StandardError => e
			puts e.message
		end
	end

	def add_to_customers
		raise DuplicateProductError, "'#{@name}' already exists." if Customer.find_by_name(@name)
		@@customers << self
	end

	# All class method

	# Return all customers
	def self.all
		@@customers
	end

    # Return a single custpmer based on its nams or nil
    # if no customer found
    # Param:
    #  +name+: The customer name.
	def self.find_by_name(name)
 		@@customers.each do |customer|
 			next if customer.name != name
 			return customer
		end
		return nil
	end

end