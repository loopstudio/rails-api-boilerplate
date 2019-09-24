task :analyze_code do
  sh 'bundle exec rubocop app config lib spec db'
  sh 'bundle exec reek app config lib'
end
