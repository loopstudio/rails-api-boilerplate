# frozen_string_literal: true

require 'spec_helper'

require 'rubocop'
require 'rubocop/rspec/support'

require_relative '../../../../rubocop/cop/migration/add_index'

RSpec.describe RuboCop::Cop::Migration::AddIndex do
  include CopHelper
  include RuboCop::RSpec::ExpectOffense

  let(:cop) { described_class.new }

  before { allow(cop).to receive(:in_migration?).and_return(true) }

  context 'with concurrently and without disable_ddl_transaction!' do
    it 'reports an offense' do
      expect_offense(<<~RUBY)
        class Migration
        ^^^^^^^^^^^^^^^ Prefer using disable_ddl_transaction! and { algorithm: :concurrently } when creating an index
          def change
            add_index :table, :column, algorithm: :concurrently
          end
        end
      RUBY
    end
  end

  context 'without concurrently and without disable_ddl_transaction!' do
    it 'reports an offense' do
      expect_offense(<<~RUBY)
        class Migration
        ^^^^^^^^^^^^^^^ Prefer using disable_ddl_transaction! and { algorithm: :concurrently } when creating an index
          def change
            add_index :table, :column
            ^^^^^^^^^^^^^^^^^^^^^^^^^ Prefer using { algorithm: :concurrently } when creating an index
          end
        end
      RUBY
    end
  end

  context 'with concurrently and with disable_ddl_transaction!' do
    it 'does not report an offense' do
      expect_no_offenses(<<~RUBY)
        class Migration
          disable_ddl_transaction!
          def change
            add_index :table, :column, algorithm: :concurrently
          end
        end
      RUBY
    end
  end

  context 'without concurrently and with disable_ddl_transaction!' do
    it 'reports an offense' do
      expect_offense(<<~RUBY)
        class Migration
          disable_ddl_transaction!
          def change
            add_index :table, :column
            ^^^^^^^^^^^^^^^^^^^^^^^^^ Prefer using { algorithm: :concurrently } when creating an index
          end
        end
      RUBY
    end
  end
end
