require 'optparse'

task :linters do
  options = {}
  OptionParser.new { |opts|
    opts.on('-a') { |autofix| options[:autofix] = autofix }
  }.parse!

  sh 'git fetch origin'

  files_diff = `git diff-tree -r --no-commit-id --name-only HEAD origin/master | xargs`

  if files_diff.present?
    sh "bundle exec rubocop --force-exclusion #{'-a' if options[:autofix]} #{files_diff}"
    sh "bundle exec reek --force-exclusion -c .reek.yml #{files_diff}"
  end
end
