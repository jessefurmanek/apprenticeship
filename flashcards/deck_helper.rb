def get_number_of_decks(user,database)
  if database['users'][user]['deck_names']!=[]
    return database['users'][user]['deck_names'].length
  else
    return 0
  end
end

def get_deck_name(user, deck_index, database)
  database['users'][user]["deck_names"][deck_index]
end

def create_deck_json_index(user,deck_object,database)
  "#{deck_object["name"].upcase}_#{user.upcase}".tr(' ', '_')
end

def show_decks(user,database)
  system "clear" or system "cls"
  puts "#{user}"+"'s Decks"
  if database['users'][user]['deck_names']!=[]
    database['users'][user]['deck_names'].each_with_index do |deck, i|
      puts (i+1).to_s+") "+deck
    end
    database['users'][user]['deck_names'].length
  else
    puts "You've got no decks to select!"
    return false
  end
end

def display_edit_menu(user,database)
  system "clear" or system "cls"
  puts "Select a deck:"
  if show_decks(user,database)
    puts
    print "Enter selection: "
    deck_selection = gets.chomp.to_i-1

    if database['users'][user]['deck_names'][deck_selection]
      puts "Would you like to edit or delete that deck?"
      print "Edit/Delete (E/D)?: "
      edit_delete = gets.chomp.upcase
      case edit_delete
      when "E","EDIT"
        edit_deck(user,deck_selection, database)
      when "D" , "DELETE"
        delete_deck(user, deck_selection, database)
      else
        puts "Invalid selection  -- try again!"
        display_edit_menu(user, database)
      end
    else
      puts "That's not a deck -- try again!"
      display_edit_menu(user, database)
    end
  else
    menu(user, database)
  end
end
