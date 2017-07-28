require "sinatra"
require 'sinatra/reloader'
SECRET_NUMBER = rand(100)
def check_guess(guess)
  guess = guess.to_i
  return "Way too high!" if guess - SECRET_NUMBER >= 5
  return "Too high!" if guess > SECRET_NUMBER
  return "Way too low!" if SECRET_NUMBER - guess >= 5
  return "Too low!" if guess < SECRET_NUMBER
  "You got it right! The SECRET NUBMER is #{SECRET_NUMBER}."
end
get '/' do
  guess = params['guess']
  message = check_guess(guess)
  erb :index, :locals => {:number => SECRET_NUMBER, :message => message}
end
