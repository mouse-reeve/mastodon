Fabricator(:account) do
  username { Faker::Internet.user_name(nil, %w(_)).gsub('e', '') }
end
