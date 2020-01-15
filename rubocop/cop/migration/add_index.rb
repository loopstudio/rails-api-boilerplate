require_relative '../../migration_helpers'

module RuboCop
  module Cop
    module Migration
      # Cop that checks if indexes are added in a concurrent manner.
      class AddIndex < RuboCop::Cop::Cop
        include MigrationHelpers

        MSG_DDT = 'Prefer using disable_ddl_transaction! and { algorithm: :concurrently }'\
                    ' when creating an index'.freeze
        MSG_ALG = 'Prefer using { algorithm: :concurrently } when creating an index'.freeze

        def_node_search :disable_ddl_transaction?, '(send $_ :disable_ddl_transaction!)'

        def_node_matcher :indexes?, <<-MATCHER
          (send _ {:add_index :drop_index} $...)
        MATCHER

        def on_class(node)
          return unless in_migration?(node)

          return if ddl_transaction_disabled?

          @disable_ddl_transaction = disable_ddl_transaction?(node)
          @offensive_node = node
        end

        def on_send(node)
          return unless in_migration?(node)

          indexes?(node) do |args|
            add_offense(node, message: MSG_ALG) unless concurrently_enabled?(args.last)
            add_offense(@offensive_node, message: MSG_DDT) unless ddl_transaction_disabled?
          end
        end

        private

        def concurrently_enabled?(last_arg)
          last_arg.hash_type? && last_arg.each_descendant.any? do |node|
            next unless node.sym_type?

            concurrently?(node)
          end
        end

        def ddl_transaction_disabled?
          @disable_ddl_transaction
        end

        def concurrently?(node)
          node.children.any? { |s| s == :concurrently }
        end
      end
    end
  end
end
