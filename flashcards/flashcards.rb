require 'json'

JSON_FILE = 'flashcards.json'

def get_json_data
	file = File.read(JSON_FILE)	
	json_hash = JSON.parse(file)
	return json_hash
end

def display_user(database)
  users = []
  if !database["users"].empty?  	
  	database["users"].each_key do |k|
  		users<<k
  	end
  end
  
  users << "<new user>"

	users.each_with_index do |user, i|
		puts (i+1).to_s+") "+user
	end

	puts
	return users
end

def create_user(users,database)
	puts "what is your name?"
	user_name = gets.chomp
	user_id = user_name.upcase
	user = {"name"=>"#{user_name}", "decks"=>{}}
	
	if !database["users"]["#{user_id}"]
		database["users"]["#{user_id}"] = user
  	database_as_json = database.to_json
    updated_json_file = File.open(JSON_FILE, "w")
    updated_json_file.puts database_as_json
    updated_json_file.close
	else
		puts "Username already exists! Try again."
		create_user(users, database)
	end	

end

def select_user(database)
	puts 
	puts "Select a user:"
	users = display_user(database)
	print "Enter selection: "
	user_input = gets.chomp
  
  if users[user_input.to_i-1] == "<new user>"
  	create_user(users, database)
  elsif users[user_input.to_i-1]
  	return users[user_input.to_i-1]
  else
  	puts "that's not a valid user! try again and enter a number between 1 and #{users.size}"
		select_user(database)
		puts
  end
end

database = get_json_data

user = select_user(database)
puts database