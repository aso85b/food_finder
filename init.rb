#### Food Finder ####
#
#Launch this Ruby file from the command line
#to get started
#

APP_ROOT = File.dirname(__FILE__)

#require  "#{APP_ROOT}/lib/guide"
#reqire File.join(APP_ROOT, 'lib', 'guide.rb')
#reqire File.join(APP_ROOT, 'lib', 'guide')

$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'lib/guide'

guide = Guide.new('restaurant.txt')
guide.launch!   