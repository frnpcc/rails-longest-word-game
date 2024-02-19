require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('A'..'Z').to_a[rand(26)] }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split
    @included = included?(@word, @letters)
    @english_word = real_word?(@word)
  end

  private

  def real_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    serialized_dictionary = URI.open(url).read
    dictionary = JSON.parse(serialized_dictionary)
    dictionary["found"]
  end

  def included?(attempt, grid)
    attempt.chars.all? { |letter| attempt.count(letter) <= grid.count(letter) }
  end
end
