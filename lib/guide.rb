require 'lib/restaurant'
require 'support/string_extend'
require 'pry-byebug'

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
	action, args = get_action #do that action
	result = do_action(action, args)
	#repeat until user quits
end

conclusion

end

#-------------------------------------------
def get_action
	action = nil
	#keep asking for user input until we get a valid action
	until Guide::Config.actions.include?(action)
		puts "Actions: "+ Guide::Config.actions.join(", ") 
		print "Enter an order please: > "
		user_response = gets.chomp
		args = user_response.downcase.strip.split(' ')
		action = args.shift
	end
	return action, args

end


#-------------------------------------------
def do_action(action, args=[])

	case action
	when 'list'
		list(args=[])
	when 'find'  
		keyword = args.shift
		find(keyword)
	when 'add'
		add
	when 'quit'
		return :quit
	else
		puts "\n I do not understand that command!\n"
	end

end
#-------------------------------------------
def list(args=[])
	sort_order = args.shift
	sort_order = args.shift if sort_order == 'by'
	sort_order = "name" unless ['name', 'cuisine','price', 'phone'].include?(sort_order)


	output_action_header("Listing Restaurants")

	restaurants = Restaurant.saved_restaurants
	restaurants.sort! do |r1, r2|
		case sort_order
		when 'name'
			r1.name.downcase <=> r2.name.downcase
		when 'cuisine'
			r1.cuisine.downcase <=> r2.cuisine.downcase
		when 'price'
			r1.price.to_i <=> r2.price.to_i
		when 'phone'
		    r1.phone.to_i <=> r2.phone.to_i
		end
	end #unless

	output_restaurant_table(restaurants)
	puts "Sort using: 'list cuisine' or 'list by cuisine'\n\n"
	
end
#-------------------------------------------
def find(keyword="")
#binding.pry
	output_action_header("Find a Restaurant")
	found = nil
	if keyword
		restaurants = Restaurant.saved_restaurants
		found = restaurants.select do |rest|
			rest.name.downcase.include?(keyword.downcase) ||
			rest.cuisine.downcase.include?(keyword.downcase) ||
			(rest.price.to_i == keyword.to_i)   ||
		  (rest.phone.to_i == keyword.to_i)
		end 
		#output result
		output_restaurant_table(found)

	else
		puts "Find using a key phrase to search the restaurant list"
		puts "You must type a keyword after 'find ... '"
	end
end

#-------------------------------------------

def add
	output_action_header("Add a Restaurants")

	puts "\nAdd a restaurant\n\n".upcase
	restaurant = Restaurant.build_using_questions

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
private
def output_action_header(text)
	puts "\n#{text.upcase.center(60)}\n\n"
end
#-------------------------------------------

def output_restaurant_table(restaurants=[])

	print " " + "Name".ljust(30) 
	print " " + "Cuisine".ljust(30)
	print " " + "Price".ljust(20) 
	print " " + "Phone".rjust(6)+ "\n"
	puts "*" * 91
	restaurants.each do |rest|
		line = " " << rest.name.titleize.ljust(30) 
		line << " " + rest.cuisine.titleize.ljust(30)
		line << " " + rest.formatted_price.ljust(20)
		line << " " + rest.phone.to_s.titleize.rjust(6)
		puts line
	end
	puts "No Listing Found" if restaurants.empty?
	puts "-" * 91
end
#-------------------------------------------

end
