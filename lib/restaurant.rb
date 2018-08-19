class Restaurant

@@filepath = nil

#-------------------------------------------
def self.filepath=(path=nil)
@@filepath = File.join(APP_ROOT, path)
end

#-------------------------------------------
attr_accessor :name, :cuisine, :price

def initialize(args={})
@name    = args[:name]    || ""
@cuisine = args[:cuisine] || ""
@price   = args[:price]   || ""
end

#-------------------------------------------
def self.build_using_questions
	
	args = {}

	print "Restaurant name: "
	args[:name].name = gets.chomp.strip

    print "Cuisine name: "
	args[:cuisine].cuisine = gets.chomp.strip
    
    print "Average name: "
	args[:price].price  = gets.chomp.strip

return self.new(args)
end

#-------------------------------------------

def self.file_exists?
	#class should know if the restaurant file exists
	if @@filepath && File.exists?(@@filepath)
		return true
	else
		return false
	end
end
#-------------------------------------------

def self.file_usable?
	return false unless  @@filepath
    return false unless File.exists?(@@filepath)
    return false unless File.readable?(@@filepath)
    return false unless File.writable?(@@filepath)    	
    return true
end
#-------------------------------------------

def self.create_file
	#create the restaurant file
    File.open(@@filepath, 'w') unless  file_exists?
    return file_usable? 	
   
end
#-------------------------------------------

def self.saved_restaurants
	#read the restaurant file
	#return instances of restaurant	
end
#-------------------------------------------
def save

	return false unless Restaurant.file_usable?
	File.open(@@filepath, 'a') do |file|
		file.puts "#{[@name, @cuisine, @price].join("\t")}\n"
	end
	return true
end

#-------------------------------------------

end