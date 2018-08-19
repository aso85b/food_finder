require "restaurant"
class Guide 

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
	print "> "
	user_response = gets.chomp
	#do that action
	result = do_action(user_response)
	#repeat until user quits
    end

	conclusion

end

#-------------------------------------------
def do_action(action)

	case action
	when 'list'
		puts "Listing..."
	when 'find'
		puts "Finding..."
	when 'add'
		puts 'Adding'
	when 'quit'
		return :quit
	else
		puts "\n I do not understand that command!\n"
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
