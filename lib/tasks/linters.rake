require 'optparse'

task :linters do
  options = {}
  OptionParser.new { |opts|
    opts.on('-a') { |autofix| options[:autofix] = autofix }
  }.parse!

  sh "bundle exec rubocop --force-exclusion #{'-a' if options[:autofix]}"
  sh 'bundle exec reek --force-exclusion -c .reek.yml'
end
