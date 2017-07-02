desc "Study State Setup"


namespace :db do
task :setup_study_state, [:args] => :environment do |t, args|
  Rails.root.join
  Rails.application.eager_load!
  DatabaseCleaner.clean_with(:truncation, :only => [:study_states])#reset the id
  File.open('./lib/tasks/data/study_states') do |f|
    StudyState.transaction do
      f.each_line do |l|
        id, name = l.split
          StudyState.create!(
            id: id, name: name
          )
      end
    end
  end
  puts "====All study states setup complete[#{Rails.env}]===="
end
end
