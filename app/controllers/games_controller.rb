class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def new
    @letters = []
    @all_letters = ('A'..'Z').to_a
    10.times do
      @letters << @all_letters.sample.to_s
    end
  end

  def score
    @letters = params[:letters].split
    @word = (params[:word] || '').upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://dictionary.lewagon.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
