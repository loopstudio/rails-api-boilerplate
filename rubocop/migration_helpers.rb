module RuboCop
  # Module containing helper methods for writing migration cops.
  module MigrationHelpers
    # Returns true if the given node originated from the db/migrate directory.
    def in_migration?(node)
      dirname(node).end_with?('db/migrate')
    end

    private

    def dirname(node)
      File.dirname(node.location.expression.source_buffer.name)
    end
  end
end
