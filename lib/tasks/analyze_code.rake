task :analyze_code do
  sh 'bundle exec rubocop app config lib'
  sh 'bundle exec reek app config lib'
end
