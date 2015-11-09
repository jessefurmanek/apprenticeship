require 'Time'

def play_deck(user,database)
  puts "Which deck do you want to play?"
  show_decks(user,database)
  print "Enter selection: "
  selection = gets.chomp.to_i-1

  if database['users'][user]['deck_names'][selection]
    #put cards into array that need to be played
    review_deck = []
    review_deck = make_array_of_deck(user, selection, database)
    if !review_deck.empty?
      review_cards(user,selection,database, review_deck)
    else
      puts "No cards to play -- wait a bit"
    end
  else
    puts "Invalid selection, try again."
    play_deck(user,database)
  end

end

def make_array_of_deck(user,deck_index,database)
  deck_as_hash = database["user_decks"][get_deck_name(user, deck_index, database)]['cards']
  card_names_as_array = []

  deck_as_hash.each_key do |card_key|
    if Time.parse(deck_as_hash[card_key]['last_review'])+\
      deck_as_hash[card_key]['current_interval'] <= Time.now
      card_names_as_array<<card_key
    end
  end
  card_names_as_array
end


def review_cards(user,deck_index,database, review_deck)
  review_deck.each do |card|
    system "clear" or system "cls"
    show_front(user,deck_index,database,card)
    puts "Guess the answer and hit enter to continue"
    gets.chomp
    puts show_back(user,deck_index,database,card)
    print "Did you get it right? (Y/N)"
    answer = gets.chomp
    if ["Y", "YES"].include?(answer.upcase)
      update_card_correct(user,deck_index, database, card)
    else
      update_card_incorrect(user,deck_index, database, card)
    end
  end
end
