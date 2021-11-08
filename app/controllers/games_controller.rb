require "open-uri"
class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    good = "Nice word bro. You made #{params[:word]} from #{params[:letters]}. #{params[:word].length} points."
    bad = "Wrong letters geezer. Can't make #{params[:word]} from #{params[:letters]}."
    if english_word?(params[:word])
      subset?(params[:word].split(''), params[:letters].split(' ')) ? @result = good : @result = bad
    else
      @result = "#{params[:word]} is not an English word, mate."
    end
  end

  private

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    word_serialized = URI.open(url).read
    json = JSON.parse(word_serialized)
    json['found']
  end

  def subset?(first, second)
    first.all? { |letter| second.include?(letter) }
  end
end
