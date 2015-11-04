require 'json'

def get_JSON_data
	file = File.read('flashcards.json')	
	json_hash = JSON.parse(file)
	return json_hash
end

database = get_JSON_data

def display_user(database)
  users = []
  if !database["users"].empty?  	
  	database["users"].each_key do |k|
  		users<<k
  	end
  else
  	users = ["<new user>"]
	end

	users.each_with_index do |user, i|
		puts (i+1).to_s+") "+user
	end

	return users
end

def create_user(users)
	puts "what is your name?"
end

def select_user(database)
	puts "Select a user:"
	users = display_user(database)
	print "?"
	user_input = gets.chomp
  
  if users[user_input.to_i-1]
  	return users[user_input.to_i-1]
  else
  	if users[user_input.to_i-1] == "<new user>"
  		create_user(users)
  	else
  		puts "that's not a valid user! try again"
  	end
  end
end




user = select_user(database)




