=begin
あるテーブルのレコードを削除する
=end
require 'hoby'

(9000..10010).each do |i|
  if Hoby.find(i)
    Hoby.find(i).delete
  end
end
