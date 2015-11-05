require_relative "card_actions.rb"

def edit_deck(deck, user, database)
  puts database
  puts "What do you want to do?"
  puts
  menu_options = ["Add Card", "Edit Card", "Delete Card", "View Card", "Go to Menu"]
	menu_options.each_with_index do |option, i|
		puts (i+1).to_s+") "+option
	end
	puts
	print "Enter selection: "
  user_input = gets.chomp.to_i

  case user_input
  when 1
    add_card(deck, user, database)
  when 2
    edit_card(deck, user, database)
  when 3
    delete_card(deck, user, database)
  when 4
    view_card(deck, user, database)
  when 5
    menu(user, database)
  else
    puts "Invalid Entry! Try again."
    edit_deck(deck, database)
  end
end

def create_deck(user, database)
  puts "What is the name of your deck?"
  puts
  print "Enter name: "
  deck_name = gets.chomp
  deck = {}
  deck['name'] = deck_name
  deck['user'] = user
  deck['cards'] = {}
  deck['json_index'] = "#{deck["name"].upcase}_#{deck["user"].upcase}".sub(/ /, '_')
  if !database["user_decks"][deck["json_index"]]
    database["user_decks"][deck["json_index"]] = deck
    edit_deck(deck, user, database)
  else
    puts "Deck name already exists! Choose another name."
    create_deck(user, database)
  end
end
