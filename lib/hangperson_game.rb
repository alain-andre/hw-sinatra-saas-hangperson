class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = @wrong_guesses = ''
  end

  def guess(word)
    raise ArgumentError if word == ""
    raise ArgumentError if ((word =~ /[\w]/i) == nil) == true
    if ((word =~ /[#{@word}]/i).class == Fixnum) == true
      if @guesses.empty?
        @guesses = word 
        return true
      else 
        if ((word =~ /[#{@guesses}]/i).class == Fixnum) == true # repeated
          return false
        else
          @guesses = word
          return true
        end
      end
    else
      @wrong_guesses = word 
      return true
    end
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
