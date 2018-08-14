class MyCasesController < ApplicationController
  def index
    cases = view_my_cases.execute(random_tenancy_refs)
    render json: cases
  end

  def sync
    sync = Hackney::Income::DangerousSyncCases.new(prioritisation_gateway: Hackney::Income::UniversalHousingPrioritisationGateway.new, uh_tenancies_gateway: Hackney::Income::UniversalHousingTenanciesGateway.new, stored_tenancies_gateway: Hackney::Income::StoredTenanciesGateway.new)
    sync.execute
  end

  private

  def view_my_cases
    Hackney::Income::DangerousViewMyCases.new(
      tenancy_api_gateway: Hackney::Income::TenancyApiGateway.new(host: ENV['INCOME_COLLECTION_API_HOST'], key: ENV['INCOME_COLLECTION_API_KEY']),
      stored_tenancies_gateway: Hackney::Income::StoredTenanciesGateway.new
    )
  end

  def random_tenancy_refs
    Hackney::Income::Models::Tenancy.first(100).map { |t| t.tenancy_ref }
  end
end
