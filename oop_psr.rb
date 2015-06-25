

class Player 
  attr_reader :name
  attr_accessor :pick
  
  def initialize(name)
    @name = name
  end
end

class Human < Player
  def pick_item
    begin
      system "clear"
      puts "Please pick one: (p, r, s)"
      puts 
      self.pick = gets.chomp.downcase
    end until Game::CHOICES.keys.include?(pick)
    puts "You pick #{ pick }"
  end
end

class Computer < Player
  def pick_item
    self.pick = Game::CHOICES.keys.sample
    puts "Computer picks #{pick}"
  end
end
  
module HandPick
  def display_winning_message(winning_pick)
    case winning_pick
    when 'p'
      puts 'Paper wraps Rock!'
    when 'r'
      puts 'Rock samashes Scissors!'
    when 's'
      puts 'Scissors cuts Paper!'
    end
  end
  
  def compare
    if human.pick == computer.pick
      puts "It's a tie!"
    elsif (human.pick == 'p' && computer.pick == 'r') || 
          (human.pick == 'r' && computer.pick == 's') ||
          (human.pick == 's' && computer.pick == 'p')
      display_winning_message(human.pick)
      puts "You won!"
    else
      display_winning_message(computer.pick)
      puts "Computer won!"
    end
  end
end

class Game 
  include  HandPick
  
  CHOICES = { 'p' => 'Paper', 'r' => 'Rock', 's' => 'Scissors' }
  attr_reader :human, :computer
  
  def initialize 
    @human = Human.new("You")
    @computer = Computer.new("Computer")
  end
  
  def intro_message
    system 'clear'
    puts "Welcome! Let's play paper, scissor and rock game!"
    puts "p = Paper, r = Rock, S = scissor"
  end
  
  def play
    intro_message
    human.pick_item
    computer.pick_item
    compare
    replay
    system "clear"
  end
  
  def replay
    play_again = "n"
    
    while play_again != "y"
      puts "Play again? (y/n)"
      puts
    
      play_again =  gets.chomp.downcase
      
      unless %w(y n).include?(play_again)
        puts "Invalid entry, please type again."
        next
      end
      
      if play_again == 'y'
        Game.new.play
      elsif play_again == 'n'
        puts "Thank you for playing!"
        exit
      end
    end
  end
  
end

Game.new.play