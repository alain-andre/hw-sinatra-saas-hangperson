class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  attr_accessor :word, :guesses, :wrong_guesses
  attr_reader   :word_with_guesses
  
  def initialize(word)
    @word = word
    @guesses = @wrong_guesses = ''
    @word_with_guesses = '' << "-" * @word.length
  end

  def guess(word)
    raise ArgumentError if word == nil
    raise ArgumentError if word.empty? || word == nil
    raise ArgumentError if ((word =~ /[\w]/i) == nil) == true
    # Correct guess
    if (@word =~ /#{word}/i).class == Fixnum
      if (@guesses =~ /#{word}/i).class == Fixnum # repeated
        return false
      end
      set_word_with_guesses word
    else # wrong guess
      if (@wrong_guesses =~ /#{word}/i).class == Fixnum # repeated
        return false
      else
        @wrong_guesses += word
      end
      return true
    end
  end

  ## 
  def set_word_with_guesses word 
    @guesses = word
    position = 0
    @word.each_char do |char|
      if (char =~ /#{word}/i).class == Fixnum
        @word_with_guesses[position] = word    
      end
      position += 1
    end
  end

  ## 
  def check_win_or_lose
    return :lose if @wrong_guesses.length == 7

    char_count = 0
    @word_with_guesses.each_char do |letter|
      char_count += 1 if (@word =~ /#{letter}/i).class == Fixnum
    end

    if char_count == @word.length
      return :win
    else
      return :play
    end
  end

  ##
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
