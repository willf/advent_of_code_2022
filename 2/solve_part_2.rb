# Day 2: Rock Paper Scissors

# Part 1: Rock Paper Scissors Rules

# Write a method `rock_paper_scissors` that takes in a string (either "rock", "paper" or "scissors")
# and returns a string indicating whether the user won, lost, or tied.

# Write a method `rock_paper_scissors` that takes in two strings (either "rock", "paper" or "scissors")
# and returns a score with two parts.
# The first part:
# 1 if the first string is "rock"
# 2 if the first string is "paper"
# 3 if the first string is "scissors"
# The second part:
# 3 if both strings are the same
# 6 if the first string is "rock" and the second string is "scissors"
# 6 if the first string is "paper" and the second string is "rock"
# 6 if the first string is "scissors" and the second string is "paper"
# Otherwise, return 0

def rock_paper_scissors_first_part(user1, user2)
  # return
  # 1 if the first string is "rock"
  # 2 if the first string is "paper"
  # 3 if the first string is "scissors"
  return 1 if user1 == "rock"
  return 2 if user1 == "paper"
  return 3 if user1 == "scissors"
end

def rock_paper_scissors_second_part(user1, user2)
  # return
  # 3 if both strings are the same
  # 6 if the first string is "rock" and the second string is "scissors"
  # 6 if the first string is "paper" and the second string is "rock"
  # 6 if the first string is "scissors" and the second string is "paper"
  # Otherwise, return 0
  return 3 if user1 == user2
  return 6 if user1 == "rock" && user2 == "scissors"
  return 6 if user1 == "paper" && user2 == "rock"
  return 6 if user1 == "scissors" && user2 == "paper"
  return 0
end

def rock_paper_scissors(user1, user2)
  # return sum of parts
  first_part = rock_paper_scissors_first_part(user1, user2)
  second_part = rock_paper_scissors_second_part(user1, user2)
  return first_part + second_part
end

def convert_from_letter_to_player(letter)
  return "rock" if letter =~ /[a]/i
  return "paper" if letter =~ /[b]/i
  return "scissors" if letter =~ /[c]/i
end

def convert_from_letter_to_strategy(letter)
  return "lose" if letter =~ /[x]/i
  return "draw" if letter =~ /[y]/i
  return "win" if letter =~ /[z]/i
end

def choose_play(user1, stategy)
  return user1 if stategy == "draw"
  if stategy == "lose"
    return "rock" if user1 == "paper"
    return "paper" if user1 == "scissors"
    return "scissors" if user1 == "rock"
  end
  if stategy == "win"
    return "rock" if user1 == "scissors"
    return "paper" if user1 == "rock"
    return "scissors" if user1 == "paper"
  end
end

def read_games(input)
  inputs = File.read('input.txt').split("\n")
  games = inputs.map { |input| input.split(" ") }
  converted_games = games.map { |user_1, strategy| [convert_from_letter_to_player(user_1), choose_play(convert_from_letter_to_player(user_1), convert_from_letter_to_strategy(strategy))] }
  return converted_games
end

def play_games(games)
  user_1_scores = games.map { |game| rock_paper_scissors(game[0], game[1]) }
  user_2_scores = games.map { |game| rock_paper_scissors(game[1], game[0]) }
  return user_1_scores, user_2_scores
end

games = read_games('input.txt')
user_1_scores, user_2_scores = play_games(games)
puts user_1_scores.sum
puts user_2_scores.sum
