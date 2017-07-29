require "sinatra"
require 'sinatra/reloader'
@@guesses = 5
$secret_number = rand(100)
def guess_message(guess)
  guess = guess.to_i
  if guess == $secret_number
    return "You got it right! The SECRET NUBMER was #{$secret_number}. "\
           "Guess the new number!"
  end
  @@guesses -= 1
  if @@guesses == 0
    return "You lost! You're out of guesses. Guess the new number."
  end
  return "Way too high!" if guess - $secret_number >= 5
  return "Too high!" if guess > $secret_number
  return "Way too low!" if $secret_number - guess >= 5
  return "Too low!" if guess < $secret_number
end

def color_check(guess)
  guess = guess.to_i
  if $secret_number - guess >= 5 || guess - $secret_number >= 5
    :red
  elsif $secret_number == guess
    :springgreen
  else
    :lightpink
  end
end

def generate_new_number
  $secret_number = rand(100)
  @@guesses = 5
end

get '/' do
  guess = params['guess']
  message = guess_message(guess)
  color = color_check(guess)
  generate_new_number if @@guesses == 0 || guess == $secret_number
  erb :index, :locals => {
    :number => $secret_number,
    :message => message,
    :background_color => color,
    :guess_count => @@guesses.to_s
  }
end
