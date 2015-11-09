def cards_to_array(user,deck_index,database)
  system "clear" or system "cls"
  cards_as_array = []
  database["user_decks"][get_deck_name(user,deck_index,database)]['cards'].each_key do |card|
    cards_as_array<<card
  end
  cards_as_array
end


def show_cards(user,deck_index,database)
  system "clear" or system "cls"
  cards = cards_to_array(user, deck_index, database)

  if !cards.empty?
    cards.each_with_index do |card,i|
      puts (1+i).to_s+") "+card
    end
    puts
  else
    puts "This deck is cardless."
    return false
  end
end



def select_a_card(user,deck_index,database,action)
  system "clear" or system "cls"
  cards = cards_to_array(user,deck_index,database)
  if show_cards(user, deck_index, database)
    puts "Which card do you want to #{action}?"
    print "Enter a number) "
    user_selection = gets.chomp.to_i
    if cards[user_selection-1]
      cards[user_selection]
    else
      puts "Invalid Selection"
    end
  else
    return false
  end
end

def show_front(user,deck_index,database,card)
  puts database["user_decks"][get_deck_name(user,deck_index,database)]["cards"][card]["front"]
end

def show_back(user,deck_index,database,card)
  puts database["user_decks"][get_deck_name(user,deck_index,database)]["cards"][card]["back"]
end

def update_card_correct(user, deck_index, database, card)
  new_interval = database["user_decks"][get_deck_name(user, deck_index, database)] \
  ["cards"][card]["current_interval"].to_i*2

  database["user_decks"][get_deck_name(user, deck_index, database)]\
  ["cards"][card]["current_interval"] = new_interval

  database["user_decks"][get_deck_name(user, deck_index, database)]\
  ["cards"][card]["last_review"] = Time.now
  update_database(database)
end

def update_card_incorrect(user, deck_index, database, card)
  new_interval = database["user_decks"][get_deck_name(user, deck_index, database)] \
  ["cards"][card]["current_interval"].to_i*0.5

  database["user_decks"][get_deck_name(user, deck_index, database)]\
  ["cards"][card]["current_interval"] = new_interval

  database["user_decks"][get_deck_name(user, deck_index, database)]\
  ["cards"][card]["last_review"] = Time.now
  update_database(database)
end
