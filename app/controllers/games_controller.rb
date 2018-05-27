require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    vowels = 4.times.map { %w(a e i o u).to_a[Random.rand(0..4)] }
    letters = 6.times.map { ("a".."z").to_a[Random.rand(0..25)] }
    @letters = vowels.push(*letters).shuffle
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
    if @realword && @canbuild
      session[:score] += guess.length
    end
  end

  def reset_game
    session[:score] = 0
  end
end
