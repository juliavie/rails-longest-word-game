class GamesController < ApplicationController
  require 'json'
  require 'open-uri'

  def score
    @word = params[:letters]
    @input = params[:input]
    @array = []
    @result = ""
    if check_letters(@word, @input)
      @result = "Yes you are cool"
      english_word = parser(@input) ? "english" : "not english"
      @result = "the word #{@input} is #{english_word}"
    else
      @result = "you can't make the word #{@input} out of these letters"
    end
  end

  def check_letters(word, input)
    input.split('').all? { |letter| input.count(letter) <= word.count(letter) }
  end

  def parser(input)
    url = "https://wagon-dictionary.herokuapp.com/#{input}"
    user_serialized = open(url).read
    user = JSON.parse(user_serialized)
    user['found']
  end

  def new
    @letters = [*('a'..'z')].sample(10)
  end
end




