require "restaurant"
class Guide 
#-------------------------------------------
class Config
	@@actions = ['list', 'find', 'add', 'quit']
	def self.actions; @@actions; end
end
#-------------------------------------------
def initialize(path=nil)

 #locate the restaurant text file at path
 Restaurant.filepath = path

 #or create a new file
 #exit if create fails
 if Restaurant.file_usable?
 	puts "Found restaurant file."
 elsif Restaurant.create_file
 	puts "Created restaurant file."
 else
 	puts "Exiting...\n\n"
 	exit! #program exits anyway!
 end
end
#-------------------------------------------
def launch!
	introduction

	#action loop
	result = nil
	until result == :quit
	#what do you want to do?(list,find,add,quit)
	action = get_action #do that action
	result = do_action(action)
	#repeat until user quits
    end

	conclusion

end

#-------------------------------------------
def get_action
	action = nil
	#keep asking for user input until we get a valid action
	until Guide::Config.actions.include?(action)
		puts "Actions: "+ Guide::Config.actions.join(", ") if action
		print "> "
		user_response = gets.chomp
		action = user_response.downcase.strip
	end
	return action
		
	end


#-------------------------------------------
def do_action(action)

	case action
	when 'list'
		puts "Listing..."
	when 'find'
		puts "Finding..."
	when 'add'
		add
	when 'quit'
		return :quit
	else
		puts "\n I do not understand that command!\n"
	end

end
#-------------------------------------------
def add

	puts "\nAdd a restaurant\n\n".upcase
	restaurant = Restaurant.new

	print "Restaurant name: "
	restaurant.name = gets.chomp.strip

    print "Cuisine name: "
	restaurant.cuisine = gets.chomp.strip
    
    print "Average name: "
	restaurant.price = gets.chomp.strip

if restaurant.save
	puts "\n Restaurant Added\n\n"
else
	puts "\nSave Error: Restaurant not Added\n\n"
end
end
#-------------------------------------------
def introduction
 puts "\n\n<<< Welcome to the Food Finder Program >>>\n\n"
 puts "This is an interactive guide to help you find the food you crave.\n\n"
end

#-------------------------------------------
def conclusion
	puts "\n<<< Goodbye an Bon Appetit! >>>\n\n\n"
end
#-------------------------------------------
end
