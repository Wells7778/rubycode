#畫出棋盤
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input(board)
  puts "現在是第#{count_round(board)}回合，輪到#{current_player(count_round(board))}，請輸入棋步（1~9）"
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
#列印出棋盤
display_board(board)
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
#電腦輸入棋步
def check_win(board,counter)
  if counter >= 3
    (0...2).each do |i|
      if board[i] != " " && board[i] == board[i+3] && board[i] == board[i+6]
        return true
      end
    end
    [0,3,6].each do |i|
      if board[i] != " " && board[i] == board[i+1] && board[i] == board[i+2]
        return true
      end
    end
    if board[0] != " " && board[0] == board[4] && board[0] == board[8]
      return true
    end
    if board[2] != " " && board[2] == board[4] && board[2] == board[6]
      return true
    end
    return false
  else
    return false
  end
end

#確認贏家
def end_game(board,counter)
  if check_win(board,count_round(board))
    "遊戲結束，#{current_player(count_round(board) -1 )}獲勝！！"
  elsif count_round(board) > 9
    "遊戲結束，雙方平手！！"
  end
end
################################
board = Array.new(9, " ")
display_board(board)
while count_round(board) <= 9 && !check_win(board,count_round(board))
  play(board)
end
puts end_game(board,count_round(board))