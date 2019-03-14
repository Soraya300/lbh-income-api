require 'active_support'
module Hackney
  module Rent
    module Jobs
      class SyncCasePriorityJob < ApplicationJob
        queue_as :uh_sync_cases

        def perform(tenancy_ref:)
          if run_tenancy_sync_jobs?
            Rails.logger.info("Running '#{self.class.name}' for tenancy_ref: '#{tenancy_ref}'")
            rent_use_case_factory.sync_case_priority.execute(tenancy_ref: tenancy_ref)
          else
            Rails.logger.info("Skipping '#{self.class.name}' job for tenancy_ref: '#{tenancy_ref}' as run_tenancy_sync_jobs is set false")
          end
        end
      end
    end
  end
end