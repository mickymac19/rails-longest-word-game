require "open-uri"

class GamesController < ApplicationController
  attr_accessor :letters
  def new
    @letters = []; 10.times { letters << (65 + rand(25)).chr }
  end

  def score
    @in_grid = grid_check?(params[:word], params[:letters])
    @letters = params[:letters]
    @word = params[:word]
  end

  def grid_check?(word, letters)
      word.upcase.chars.all? { |letter| word.upcase.chars.count(letter) <=
      letter.count(letter) }
  end

  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
