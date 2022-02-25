class TicTacToe
  attr_reader :board

  WIN_COMBINATIONS = [
    [0,1,2],  # Top row
    [3,4,5],  # Middle row
    [6,7,8],  # Bottom row
    [0,3,6],  # Left collumn
    [1,4,7],  # Middle collumn
    [2,5,8],  # Right collumn
    [2,4,6],  # Left diagonal
    [0,4,8]   # Right diagonal
  ]

  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def display_board
    puts "-----------"
    puts " #{self.board[0]} | #{self.board[1]} | #{self.board[2]} "
    puts "---+---+---"
    puts " #{self.board[3]} | #{self.board[4]} | #{self.board[5]} "
    puts "---+---+---"
    puts " #{self.board[6]} | #{self.board[7]} | #{self.board[8]} "
  end

  def input_to_index(str)
    str.to_i-1
  end

  def move(index, token = "X")
    self.board[index] = token
  end

  def position_taken?(index)
    self.board[index] == "X" || self.board[index] == "O" ? true : false
  end

  def valid_move?(index)
    (0..8).to_a.include?(index) && !position_taken?(index)
  end

  def turn_count
    self.board.select { |move| move == "X" || move == "O" }.size
  end

  def current_player
    turn_count.odd? ? "O" : "X"
  end

  def turn
    puts "Please enter a number (1-9):"
    user_input = gets.strip
    index = input_to_index(user_input)
    if valid_move?(index)
      move(index, current_player)
    else
      turn
    end
    display_board
  end

  def won?
    x_arr = self.board.each_index.select { |index| self.board[index] === "X" }
    o_arr = self.board.each_index.select { |index| self.board[index] === "O" }

    WIN_COMBINATIONS.find do |maybe_win|
      maybe_win.all? { |x| x_arr.include?(x) } || maybe_win.all? { |o| o_arr.include?(o) }
    end
  end

  def full?
    turn_count == 9
  end

  def draw?
    !won? && full?
  end

  def over?
    won? || draw?
  end

  def winner
    if won?
      self.board[won?.first]
    end
  end

  def play
    turn until over?
    puts won? ? "Congratulations #{winner}!" : "Cat's Game!"
  end

end
