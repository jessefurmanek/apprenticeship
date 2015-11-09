require_relative "card_actions.rb"
require_relative "deck_helper.rb"

def edit_deck(user,deck_index, database)
  system "clear" or system "cls"
  puts "Work in progress.."
  # puts database["user_decks"][database['users'][user]["deck_names"][deck_index]]
  card_edit_menu(user, deck_index, database)
end

def create_deck(user, database)
  system "clear" or system "cls"
  puts "What is the name of your deck?"
  puts
  print "Enter name: "
  deck_name = gets.chomp
  deck = {}
  deck['name'] = deck_name
  deck['user'] = user
  deck['cards'] = {}
  deck['json_index'] = create_deck_json_index(user, deck, database)
  update_database(database)

  if !database["user_decks"][deck["json_index"]]
    puts "Create manually or upload deck?"
    print "M/U?"
    answer = gets.chomp
    database["users"][user]["deck_names"]<<deck['json_index']
    update_database(database)
    deck_index = database["users"][user]["deck_names"].length-1
    if ["M", "MANUALLY"].include?(answer.upcase)
      database["user_decks"][deck["json_index"]] = deck
      update_database(database)
      edit_deck(user,deck_index, database)
    else["U", "UPLOAD"].include?(answer.upcase)
      upload_deck(user, deck_index, database)
    end
  else
    puts "Deck name already exists! Choose another name."
    create_deck(user, database)
  end
end

def delete_deck(user,deck_index, database)
  puts "Are you sure?"
  print "Y/N: "
  answer = gets.chomp
  if ["Y", "YES"].include?(answer.upcase)
    #delete deck from user object
    database['users'][user]['deck_names'].delete_at(deck_index)
    #delete deck from user_decks obejct
    database["user_decks"].delete(get_deck_name(user, deck_index, database))
    update_database(database)
  end
  menu(user, database)
end
