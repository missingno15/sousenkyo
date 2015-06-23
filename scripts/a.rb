serial_code = "ms8zhn84 aripu7f7"
jpname = "松岡菜摘"
engname = "Matsuoka Natsumi"
puts "[  \e[32mVOTE SUCCESSFUL\e[0m  ] #{Time.now.strftime("%F %H:%M:%S.%L")} - #{"Matsuoka Natsumi".ljust(20)}; #{serial_code};"
puts "[ \e[31mVOTE UNSUCCESSFUL\e[0m ] #{Time.now.strftime("%F %H:%M:%S.%L")} - #{"Watanabe Mayu".ljust(20)}; #{serial_code}; You must enter a serial code."
puts "[ \e[31mVOTE UNSUCCESSFUL\e[0m ] #{Time.now.strftime("%F %H:%M:%S.%L")} - #{"Kato Rena".ljust(20)}; #{serial_code}; Each serial code must have 8 digits."
puts "[ \e[31mVOTE UNSUCCESSFUL\e[0m ] #{Time.now.strftime("%F %H:%M:%S.%L")} - #{"Kashiwagi Yuki".ljust(20)}; #{serial_code}; The serial code you have entered is either invalid or already previously used."


puts "[ \e[31m投票失敗\e[0m ] #{Time.now.strftime("%F %H:%M:%S.%L")} - #{"柏木由紀".ljust(10)}; #{serial_code};"
puts "[ \e[31m投票失敗\e[0m ] #{Time.now.strftime("%F %H:%M:%S.%L")} - #{"山下エミリー".ljust(10)}; #{serial_code}; シリアルナンバーは入力必須です。"
puts "[ \e[32m投票成功\e[0m ] #{Time.now.strftime("%F %H:%M:%S.%L")} - #{"東李苑".ljust(10)}; #{serial_code}; シリアルナンバーは8桁ずつ入力してください。"
puts "[ \e[32m投票成功\e[0m ] #{Time.now.strftime("%F %H:%M:%S.%L")} - #{"加藤玲奈".ljust(10)}; #{serial_code}; 入力されたシリアルナンバーは無効であるか既に投票済みです。"
