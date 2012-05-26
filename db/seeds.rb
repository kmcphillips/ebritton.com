["bio", "contact"].each do |label|

  next if Block.find_by_label(label)

  b = Block.new
  b.label = label

  b.save!

end

if Rails.env.production?
  puts "Skipped creating a user in Production mode."
else
  AdminUser.create!(:email => 'test@example.com', :password => 'password', :password_confirmation => 'password')
  puts "Created develompent user: test@example.com / password"
end

