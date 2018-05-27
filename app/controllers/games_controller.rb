require 'open-uri'
require 'json'

class GamesController < ApplicationController


  def new
    @letters = 10.times.map { ("a".."z").to_a[Random.rand(0..25)] }
  end

  def score
    guess = params[:guess].split("")
    grid = params[:grid].split("")

    def real_word
      url = "https://wagon-dictionary.herokuapp.com/#{params[:guess]}"
      guess_word = JSON.parse(open(url).read)
      guess_word["found"] == true
    end

    def can_build(guess, grid)
      guess.each { |l| grid.include?(l) ? grid.delete_at(grid.index(l)) : "" }
      grid.length == 10 - guess.length
    end

    @realword = real_word
    @canbuild = can_build(guess, grid)
    @grid_array = params[:grid].split("")

  end
end
