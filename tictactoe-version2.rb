#畫出棋盤
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input(board)
  puts "現在是第#{count_round(board)}回合，輪到玩家，請輸入棋步（1~9）"
  player_input = gets.chomp
  position = player_input.to_i - 1
  if position >= 0 && position <= 9
    if board[position] == " "
      return position
    else
      puts "已有棋子，請重新選擇！"
      input(board)
    end
  else
    puts "輸入錯誤，請輸入（1~9）！！"
    input(board)
  end

end

#玩家輸入棋步
def play(board)
#玩家輸入棋步並驗證
  board[input(board)] = current_player(count_round(board))
#電腦輸入棋步
  display_board(board)
  if count_round(board) <= 9 && !won?(board)
    puts "現在是第#{count_round(board)}回合，輪到電腦"
    board[com_play(board)] = current_player(count_round(board))
    display_board(board)
  end
end

#確認回合數
def count_round(board)
  counter = 1
  board.each do |i|
    if i == "X" || i == "O"
    counter += 1
    end
  end
  counter
end

def current_player(counter)
  if counter.even?
    return "O"
  else
    return "X"
  end
end
WIN_CON = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]
def won?(board)
  WIN_CON.each do |win_combo|
    if ( board[win_combo[0]] == "X" && board[win_combo[1]] == "X" && board[win_combo[2]] == "X" ) || ( board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O" )
      return win_combo
    end
  end
  return false
end
# 確認贏家
def winner(board)
  win_combo = won?(board)
  if win_combo
    return win_combo
  end
end
#電腦輸入棋步

def com_play(board)
  avail_position(board).sample
end

def avail_position(board)
  avail_position = Array.new
  board.each_with_index do |input,index|
    if input == " "
      avail_position << index
    end
  end
  avail_position
end
#確認贏家
def end_game(board,counter)
  if won?(board)
    if count_round(board).odd?
      "遊戲結束，電腦獲勝！！"
    elsif count_round(board).even?
      "遊戲結束，玩家獲勝！！"
    end
  elsif count_round(board) >= 9
    "遊戲結束，雙方平手！！"
  end
end
################################
board = Array.new(9, " ")
display_board(board)
while count_round(board) <= 9 && !won?(board)
  play(board)
  com_play(board)
end
puts end_game(board,count_round(board))