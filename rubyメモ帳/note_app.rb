require "csv" 

puts "Noteが呼び出されました。"

# 番号を取得するための変数の初期値を設定
select_num = 0

# もしも文字列を入力されたら、数字が入力されるまでwhileが繰り返される。
while select_num != Numeric || select_num > 2
  puts "次の選択肢のうちで実行したい数字を入力してください。"
  puts "1.(新規メモを作成), 2.(既存メモに追記)"
  select_num = gets.to_i

######______ 新規作成するときの分岐を設定 ______######
  if select_num == 1
    puts "新規メモ作成"

    puts "拡張子を除いた新規ファイル名を記入"
    new_file_name = gets.to_s.chomp
    puts "日付を記入 [例：2021/01/01 または 1月1日(金曜日) ] :"
    note_type_date = gets.to_s.chomp
    puts "内容を記入 (※ ENTER を押すと内容が保存されます。) :"
    note_type_contents = gets.to_s.chomp
    
    header = ["日付","内容"]
    data = [["#{note_type_date}","#{note_type_contents}"]]

    CSV.open("#{new_file_name}.csv","w") do |csv|
      csv << header
      data.each do |d|
        csv << d
      end
    end

    CSV.foreach("#{new_file_name}.csv", headers: true) do |row|
      p row.to_h
    end
    puts "を保存しました。"
    break

######______ 編集するときの分岐を設定 ______######
  elsif select_num == 2
    puts "既存メモ追記"
    puts "拡張子を除いた既存ファイル名を記入"
    edit_file_name = gets.to_s.chomp
    
    # 日付と内容を表示して、今まで何が入力されていたのかを確認
    CSV.foreach("#{edit_file_name}.csv") do |row| 
        p row
    end

    puts "日付を記入 [例：2021/01/01 または 1月1日(金曜日) ] :"
    note_type_date = gets.to_s.chomp
    puts "内容を記入 (※ ENTER を押すと内容が保存されます。) :"
    note_type_contents = gets.to_s.chomp
    
    # 上で指定したファイル名からファイルを取得し、上で取得した内容をファイル内に追記
    test = CSV.open("#{edit_file_name}.csv",'a')
      test.puts ["#{note_type_date}","#{note_type_contents}"]
    test.close

    CSV.foreach("#{edit_file_name}.csv", headers: true) do |row|
      p row.to_h
    end
    puts "を保存しました。"
    break
  end

  next
end
