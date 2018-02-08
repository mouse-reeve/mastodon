Fabricator(:status) do
  account
<<<<<<< HEAD
  text "Lorm ipsum dolor sit amt"
=======
  text "Lorem ipsum dolor sit amet"

  after_build do |status|
    status.uri = Faker::Internet.device_token if !status.account.local? && status.uri.nil?
  end
>>>>>>> master
end
