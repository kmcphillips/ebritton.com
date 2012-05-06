["bio", "contact"].each do |label|

  next if Block.find_by_label(label)

  b = Block.new
  b.label = label

  b.save!

end
