class Transaction

	attr_accessor :id, :customer, :product

	@@transactions = []
	@@id           = 1

	def initialize(customer, product)
		@id       = @@id
		@customer = customer
		@product  = product
		@@id     += 1
		begin
  			purchase
  		rescue StandardError => e
  			puts e.message
  		end
	end

	# Raise an exception id the product is out of stock 
	# else decrease the stock and push the transaction
	# on @@transactions
	def purchase
		raise OutOfStockError, "'#{@product.title}' is out of stock" if @product.stock == 0
		@product.stock = @product.stock - 1
		@@transactions << self
	end

	# All class method

	# Return all products
	def self.all
		@@transactions 
	end

	# Return a single transaction based on its id or nil
    # if no transaction found
    # Params:
    #  +id+: The transaction id.
	def self.find(id)
		@@transactions.each do |transaction|
 			return transaction if transaction.id == id
 		end
		return nil
	end
end