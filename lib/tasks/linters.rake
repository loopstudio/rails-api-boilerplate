require 'optparse'

task :linters do
  options = {}
  OptionParser.new { |opts|
    opts.on('-a') { |autofix| options[:autofix] = autofix }
  }.parse!

  files_diff = `git diff --diff-filter=ACMRTUXB --name-only origin/master... | \
               xargs | sed "s/\\n/\\s/"`

  if files_diff.present?
    sh "bundle exec rubocop --force-exclusion #{'-a' if options[:autofix]} #{files_diff}"
    sh "bundle exec reek --force-exclusion -c .reek.yml #{files_diff}"
  end
end
