module Hackney
  module Income
    class MigratePatchToLcw
      def initialize(legal_cases_gateway:, user_assignment_gateway:)
        @legal_cases_gateway = legal_cases_gateway
        @user_assignment_gateway = user_assignment_gateway
      end

      def execute(patch:, user_id:)
        tenancy_refs_in_legal_process = @legal_cases_gateway.get_tenancies_for_legal_process_for_patch(patch: patch)
        tenancy_refs_not_found = []
        tenancy_refs_in_legal_process.each do |ref|
          @user_assignment_gateway.assign_user(tenancy_ref: ref, user_id: user_id)
        rescue StandardError
          tenancy_refs_not_found << ref
        end
        { tenancy_refs_in_legal_process: tenancy_refs_in_legal_process, tenancy_refs_not_found: tenancy_refs_not_found }
      end
    end
  end
end
