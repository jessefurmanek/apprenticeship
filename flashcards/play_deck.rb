require 'Time'

def play_deck(user,database)
  puts "Which deck do you want to play?"
  show_decks(user,database)
  print "Enter selection: "
  selection = gets.chomp.to_i-1

  if database['users'][user]['deck_names'][selection]
    #put cards into array that need to be played
    review_deck = make_array_of_deck(user, selection, database)
    p review_deck
    review_cards(user,selection,database, review_deck)
  else
    puts "Invalid selection, try again."
    play_deck(user,database)
  end

end

def make_array_of_deck(user,deck_index,database)
  deck_as_hash = database["user_decks"][get_deck_name(user, deck_index, database)]['cards']
  card_names_in_array = []

  deck_as_hash.each_key do |card_key|
    if Time.parse(deck_as_hash[card_key]['last_review'])+\
      deck_as_hash[card_key]['current_interval'] <= Time.now
      card_names_in_array<<card_key
    end
  end
  return card_names_in_array
end


def review_cards(user,deck_index,database, review_deck)
  review_deck.each do |card|
    show_front(user,deck_index,database,card)

  end
end
