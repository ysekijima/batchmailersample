require 'base_batch'
require 'test_batch'

namespace :catcafe do
  desc 'test task'
  task run_test: :environment do
    batch = TestBatch.new('TestBatchName')
    batch.run
  end
end
