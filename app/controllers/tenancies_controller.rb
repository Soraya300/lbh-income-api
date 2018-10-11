class TenanciesController < ApplicationController
  def update
    result = income_use_case_factory.set_tenancy_paused_status.execute(
      tenancy_ref: params.fetch(:tenancy_ref),
      status: params.fetch(:is_paused)
    )

    return head(:no_content)
  end
end