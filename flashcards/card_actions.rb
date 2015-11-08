require_relative "card_helper.rb"

def card_edit_menu(user, deck, database)
  puts "What do you want to do?"
  puts
  menu_options = ["Add Card", "Edit Card", "Delete Card", "View Cards", "Go to Menu"]
	menu_options.each_with_index do |option, i|
		puts (i+1).to_s+") "+option
	end
	puts
	print "Enter selection: "
  user_input = gets.chomp.to_i

  case user_input
  when 1
    add_card(user, deck, database)
  when 2
    edit_card(user, deck, database)
  when 3
    delete_card(user, deck, database)
  when 4
    view_cards(user, deck, database)
  when 5
    menu(user, database)
  else
    puts "Invalid Entry! Try again."
    card_edit_menu(deck,user, database)
  end
end


def add_card(user, deck, database)
  system "clear" or system "cls"
  while true
    puts
    puts "What should this card be called?"
    puts
    print "Enter name: "
    name = gets.chomp
    card = {}
    if !database['user_decks'][name.upcase]
      card['name'] = name
      break
    end
  end

  puts
  puts "What should the front say?"
	puts
	print "Enter front: "
	user_input = gets.chomp
  card['front'] = user_input

  puts
  puts "What should the back say?"
  puts
  print "Enter back: "
  user_input = gets.chomp
  card['back'] = user_input

  puts
  puts "Front: #{card['front']}"
  puts "Back: #{card['back']}"
  puts
  print "Save Card?(Y/N): "
  user_input = gets.chomp

  if ["Y", "YES"].include?(user_input.upcase)
    card['current_interval'] = 600 #initial interval is 10 minutes (in seconds)
    card['last_review'] = Time.now - card['current_interval']
    deck_name = get_deck_name(user, deck, database)
    database['user_decks'][deck_name]['cards'][name] = card
  end

  update_database(database)
  edit_deck(user, deck, database)
end


def edit_card(user, deck, database)
  system "clear" or system "cls"
  card = select_a_card(user,deck,database, "edit")
end

def delete_card(user, deck, database)
  system "clear" or system "cls"
  card = select_a_card(user,deck,database, "delete")
end

def view_cards(user, deck, database)
  system "clear" or system "cls"
  if show_cards(user, deck, database)
    card_edit_menu(user,deck,database)
  end
end
