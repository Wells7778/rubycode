# 連線勝利方式
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
# 畫出棋盤
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end
# 詢問玩家先後
def player_first?
  puts "Ｘ先攻，O後攻，請輸入O或X"
  input = gets.chomp.upcase
  if input == "X"
    puts "玩家先攻"
    return true
  elsif input == "O"
    puts "電腦先攻"
    return false
  else
    puts "輸入錯誤，請重新輸入"
    player_first?
  end
end
def counter(board)
  count = board.count("O") + board.count("X")
  return count
end
def play(board)
  if player_first?
    check_turn = 0
    while counter(board) < 9 && !won?(board)
      board[player_turn_check(board)] = "X"
      display_board(board)
      if counter(board) < 9 && !won?(board)
        puts "輪到電腦"
        board[com_turn(board,check_turn)] = "O"
        display_board(board)
      end
    end
  else
    check_turn = 1
    while counter(board) < 9 && !won?(board)
      puts "輪到電腦"
      board[com_turn(board,check_turn)] = "X"
      display_board(board)
      if counter(board) < 9 && !won?(board)
        board[player_turn_check(board)] = "O"
        display_board(board)
      end
    end
  end
  if won?(board)
    puts "#{winner(board,check_turn)}"
  else
    puts "平手"
  end
end
# 確認玩家輸入是否正確
def player_turn_check(board)
  puts "輪到玩家，請輸入棋步(1~9)"
  display_board([1,2,3,4,5,6,7,8,9])
  player_input = gets.chomp
  position = player_input.to_i - 1
  if position >= 0 && position < 9
    if board[position] == " "
      return position
    else
      puts "已有棋子，請重新選擇！"
      player_turn_check(board)
    end
  else
    puts "輸入錯誤，請輸入（1~9）！！"
    player_turn_check(board)
  end
end
# 將玩家輸入加入遊戲陣列
# 電腦計算落點
def com_turn(board,check_turn)
  best_choice(board,check_turn)
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
def best_choice(board,check_turn)
  avail_pos = avail_position(board)
  # 雙方都沒有連線時中央分數50
  # 四角分數10
  # 周圍分數5
  choice = {
    0 => 30,
    1 => 20,
    2 => 30,
    3 => 20,
    4 => 40,
    5 => 20,
    6 => 30,
    7 => 20,
    8 => 30,
  }
  choice.each do |k,v|
    v += rand(6)
  end
  tmp_array = Array.new
  if check_turn == 0 #電腦是O
  # 自己的符號差一個連線則分數加999
    avail_pos.each do |avail|
      WIN_CON.each do |win_combo|
        if win_combo.include?(avail)
          tmp_array = win_combo.select {|n| n != avail }
          tmp1 = tmp_array[0]
          tmp2 = tmp_array[1]
          if board[tmp1] == "O"
            if board[tmp2] == "O"
              choice[avail] += 999
            end
            choice[avail] += 50
          elsif board[tmp1] == "X"
            if board[tmp2] == "X"
              choice[avail] += 500  # 對方符號差一個連線則分數加500
            end
            choice[avail] += 50
          end
        end
      end
    end
  elsif check_turn == 1
    avail_pos.each do |avail|
      WIN_CON.each do |win_combo|
        if win_combo.include?(avail)
          tmp_array = win_combo.select {|n| n != avail }
          tmp1 = tmp_array[0]
          tmp2 = tmp_array[1]
          if board[tmp1] == "X"
            if board[tmp2] == "X"
              choice[avail] += 999
            end
            choice[avail] += 50
          elsif board[tmp1] == "O"
            if board[tmp2] == "O"
              choice[avail] += 500  # 對方符號差一個連線則分數加500
            end
            choice[avail] += 50
          end
        end
      end
    end
  end
    return choice.key(choice.values.max)
end

# 確認勝利
def won?(board)
  WIN_CON.each do |win_combo|
    if ( board[win_combo[0]] == "X" && board[win_combo[1]] == "X" && board[win_combo[2]] == "X" ) || ( board[win_combo[0]] == "O" && board[win_combo[1]] == "O" && board[win_combo[2]] == "O" )
      return win_combo
    end
  end
  return false
end
# 確認贏家
def winner(board,check_turn)
  win_combo = won?(board)
  if win_combo
    if check_turn == 0 && board[win_combo[0]] == "X"
      return "玩家獲勝"
    elsif check_turn == 0 && board[win_combo[0]] == "O"
      return "電腦獲勝"
    elsif check_turn == 1 && board[win_combo[0]] == "X"
      return "電腦獲勝"
    elsif check_turn == 1 && board[win_combo[0]] == "O"
      return "玩家獲勝"
    end
  end
end
# ##############################
board = Array.new(9," ")
puts "歡迎來到Wells的井字遊戲"
play(board)
