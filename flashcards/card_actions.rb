def add_card(deck, user, database)
  while true
    puts
    puts "What should this card be called?"
    puts
    print "Enter name: "
    name = gets.chomp
    card = {}
    if !deck['cards'][name.upcase]
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
    deck["cards"][card['name']] = card
  end

  edit_deck(deck, user, database)
end

def edit_card(deck, user, database)
end

def delete_card(deck, user, database)
end

def view_card(deck, user, database)
end
