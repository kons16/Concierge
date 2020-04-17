=begin
find_byメソッドでインデックス有無での処理時間をテストする
=end
require 'benchmark'

num_iteration = 10000

Benchmark.bm 10 do |r|
  r.report "no-index2" do
    num_iteration.times do
      hoby = Hoby.find_by(hoby_name: "#{rand(1..1000)}")
    end
  end
end
