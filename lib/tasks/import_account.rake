desc "Static data import"


namespace :db do
task :import_account, [:args] => :environment do |t, args|
  Rails.root.join
  Rails.application.eager_load!
  DatabaseCleaner.clean_with(:truncation, :only => [:users])#reset the id
  File.open('./deploy/accounts.deploy_data') do |f|
    User.transaction do
      f.each_line do |l|
        name, account = l.split
          User.create!(
            name: name, nickname: name, account: account, stu_id: account, email: "#{account}@example.com",
            password: account, password_confirmation: account
          )
      end
    end
  end
  puts "====All account import complete[#{Rails.env}]===="
end
end

