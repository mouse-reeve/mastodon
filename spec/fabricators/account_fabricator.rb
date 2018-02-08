Fabricator(:account) do
<<<<<<< HEAD
  username { Faker::Internet.user_name(nil, %w(_)).gsub('e', '') }
=======
  username { sequence(:username) { |i| "#{Faker::Internet.user_name(nil, %w(_))}#{i}" } }
>>>>>>> master
  last_webfingered_at { Time.now.utc }
end
