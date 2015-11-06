require 'json'
require_relative "user.rb"
require_relative "deck_actions.rb"

JSON_FILE = 'flashcards.json'

def get_json_data
	file = File.read(JSON_FILE)
	json_hash = JSON.parse(file)
	return json_hash
end

def update_database(database)
	File.open(JSON_FILE,"w") do |f|
		f.write(database.to_json)
	end
end

def menu(user, database)
	puts
  puts "What do you want to do?"
	menu_options = ["Create Deck", "Edit/Delete a Deck", "Play Deck","Quit"]
	menu_options.each_with_index do |option, i|
		puts (i+1).to_s+") "+option
	end
	puts
	print "Enter selection: "
	user_input = gets.chomp.to_i

  case user_input
	when 1
		create_deck(user, database)
	when 2
		display_edit_menu(user,database)
	when 3
		play_deck(user,database)
	when 4
		puts "Seeee ya later"
	else
		puts "Invalid Entry! Try again."
		menu(user, database)
	end
end


database = get_json_data

user = select_user(database)
menu(user, database)
