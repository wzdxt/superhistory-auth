desc 'fetch user'
task :fetch_user  => :environment do
  User2.all.each do |user2|
    user = User.find_or_create_by :id => user2.id
    user.update user2.attributes
    p "fetch user #{user.id}"
  end
end
