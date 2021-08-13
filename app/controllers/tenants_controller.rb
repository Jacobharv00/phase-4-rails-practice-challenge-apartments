class TenantsController < ApplicationController
  wrap_parameters format: []
  
  def index
    tenants = Tenant.all
    render json: tenants, include: [:apartments, :leases]
  end

  def create
    tenant = Tenant.create(tenant_params)
    if tenant.valid?
      render json: tenant, include: [:apartments, :leases], status: :created
    else
      render json: {error: tenant.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    tenant = find_tenant
    if tenant.update(tenant_params)
      render json: tenant, include: [:apartments, :leases], status: :ok
    else
      render json: {error: tenant.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    tenant = find_tenant
    tenant.destroy
    head :no_content
  end

  
  private

  def tenant_params
    params.permit(:name, :age)
  end

  def find_tenant
    Tenant.find(params[:id])
  end

end
