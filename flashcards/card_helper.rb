def cards_to_array(user,deck,database)
  system "clear" or system "cls"
  cards_as_array = []
  database["user_decks"][get_deck_name(user,deck,database)]['cards'].each_key do |card|
    cards_as_array<<card
  end
  cards_as_array
end


def show_cards(user,deck,database)
  system "clear" or system "cls"
  cards = cards_to_array(user, deck, database)

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



def select_a_card(user,deck,database,action)
  system "clear" or system "cls"
  cards = cards_to_array(user,deck,database)
  if show_cards(user, deck, database)
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
