every 1.day, :at => "1:00 am" do
  command "cd #{@rails_root} && bundle exec rails runner -e #{@environment} script/clean_database.rb"
end
