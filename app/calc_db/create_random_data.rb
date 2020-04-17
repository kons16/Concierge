require 'hoby'

10000.times do
  Hoby.create!(hoby_name: (0...8).map{ ('A'..'Z').to_a[rand(26)] }.join)
end
