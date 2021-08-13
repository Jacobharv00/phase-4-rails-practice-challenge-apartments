class LeasesController < ApplicationController
  wrap_parameters format: []

  # made this just to see data
  def index
    leases = Lease.all
    render json: leases
  end

  def create
    lease = Lease.create(lease_params)
    if lease.valid?
      render json: lease, include: [:tenant, :apartment], status: :created
    else
      render json: {error: lease.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    lease = Lease.find(params[:id])
    lease.destroy
    head :no_content
  end

  private

  def lease_params
    params.permit(:rent, :apartment_id, :tenant_id)
  end


end
