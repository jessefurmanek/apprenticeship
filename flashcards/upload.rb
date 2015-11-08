require 'csv'
require 'json'
require_relative 'user.rb'

def upload_deck(user,deck_index, database)
  puts "What is the name of the file?"
  f = gets.chomp
  if File.exist?(f)
    csv = CSV.read(f,headers:true)

    deck = {}
    deck['name'] = get_deck_name(user, deck_index,database)
    deck['user'] = user
    deck['json_index'] = create_deck_json_index(user,deck, database)
    csv.each do |row|
      card = {}
      a = row.to_a
      card[a[0][0]] = a[0][1]
      card[a[1][0]] = a[1][1]
      card[a[2][0]] = a[2][1]
      card['current_interval'] = 600 #initial interval is 10 minutes (in seconds)
      card['last_review'] = Time.now- card['current_interval']
      deck[card['Title']] = card
    end

    database["user_decks"][deck["json_index"]] = deck
    update_database(database)
    menu(user, database)
  else
    puts "File not found -- try again!"
    upload_deck(user,deck,database)
  end
end
