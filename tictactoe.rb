#建立方格
def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]}"
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]}"
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]}"
end

#計算步數
def turn_count(board)
  counter = 0
  board.each do |i|
    if i == "O" || i == "X"
      counter += 1
    end
  end
  counter
end
#依照步數給圖案
def current_player(board)
  if turn_count(board).even?
    current_player = "O"
  elsif turn_count(board).odd?
    current_player = "X"
  end
end
#檢查勝負
  #如果一列同符號或一豎同符號或對角線同符號則該符號勝利
def check_row(board)
  [0,3,6].each do |i|
    if board[i] != " " && board[i] == board[i+1] && board[i] == board[i+2]
      return true
    end
  end
  (0...2).each do |i|
    if board[i] != " " && board[i] == board[i+3] && board[i] == board[i+6]
      return true
    end
  end
  if board[0] != " " && board[0] == board[4] && board[0] == board[8]
    return true
  elsif board[2] != " " && board[2] == board[4] && board[2] == board[6]
    return true
  end
  return false
end

#初始棋盤
def clearall(board)
  [" "," "," "," "," "," "," "," "," "]
end
board = clearall(board)
puts "Wells的井字遊戲！！"
puts "Player1 : O"
puts "Player2 : X"
puts " 1 | 2 | 3"
puts "-----------"
puts " 4 | 5 | 6"
puts "-----------"
puts " 7 | 8 | 9\n\n"
nomore = false
ans = ""
until nomore
  puts "請問您的棋步（1～9），結束請輸入0"
  step = gets.chomp.to_i
  if step < 0 || step > 9
    puts "輸入錯誤！！請輸入1～9數字"
  elsif board[step-1] != " "
    puts "此步已有下過！！請重新選擇！"
  elsif step == 0
    nomore = true
  else
    board[step-1] = current_player(board)
    if check_row(board)
      if turn_count(board).even? 
        system("cls")
        puts "Wells的井字遊戲！！"
        puts "Player1 : O"
        puts "Player2 : X"
        puts " 1 | 2 | 3"
        puts "-----------"
        puts " 4 | 5 | 6"
        puts "-----------"
        puts " 7 | 8 | 9\n\n"
        display_board(board)
        until ans == "Y" || ans == "N"
        puts "Player1 贏了！！\n\n要再玩一場嗎？（Y/N）"
        ans = gets.chomp!.upcase
        end
        if ans == "Y"
          board = clearall(board)
        elsif ans == "N"
          nomore = true
        end
      elsif turn_count(board).odd?
        system("cls")
        puts "Wells的井字遊戲！！"
        puts "Player1 : O"
        puts "Player2 : X"
        puts " 1 | 2 | 3"
        puts "-----------"
        puts " 4 | 5 | 6"
        puts "-----------"
        puts " 7 | 8 | 9\n\n"
        display_board(board)
        until ans == "Y" || ans == "N"
        puts "Player2 贏了！！\n\n要再玩一場嗎？（Y/N）"
        ans = gets.chomp!.upcase
        end
        if ans == "Y"
          board = clearall(board)
        elsif ans == "N"
          nomore = true
        end
      end
    elsif turn_count(board) == 9
      system("cls")
      puts "Wells的井字遊戲！！"
      puts "Player1 : O"
      puts "Player2 : X"
      puts " 1 | 2 | 3"
      puts "-----------"
      puts " 4 | 5 | 6"
      puts "-----------"
      puts " 7 | 8 | 9\n\n"
      display_board(board)
      until ans == "Y" || ans == "N"
        puts "平分秋色！！\n\n要再玩一場嗎？（Y/N）"
        ans = gets.chomp!.upcase
      end
      if ans == "Y"
        board = clearall(board)
      elsif ans == "N"
        nomore = true
      end
    else
      system("cls")
      puts "Wells的井字遊戲！！"
      puts "Player1 : O"
      puts "Player2 : X"
      puts " 1 | 2 | 3"
      puts "-----------"
      puts " 4 | 5 | 6"
      puts "-----------"
      puts " 7 | 8 | 9\n\n"
      display_board(board)
    end
  end
end