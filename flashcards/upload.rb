require 'csv'
require 'json'
require_relative 'user.rb'

def upload_deck(user,deck, database)
  puts "What is the name of the file?"
  f = gets.chomp
  if File.exist?(f)
    csv = CSV.read(f,headers:true)

    cards = {}
    csv.each do |row|
      card = {}
      a = row.to_a
      card[a[0][0]] = a[0][1]
      card[a[1][0]] = a[1][1]
      card[a[2][0]] = a[2][1]
      cards[card['Title']] = card
    end

    database["user_decks"][deck["json_index"]] = cards
    database["users"][user]["deck_names"]<<create_deck_json_index(user,deck,database)
    update_database(database)
    menu(user, database)
  else
    puts "File not found -- try again!"
    upload_deck(user,deck,database)
  end
end
