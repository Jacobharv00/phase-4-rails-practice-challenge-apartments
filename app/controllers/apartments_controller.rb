class ApartmentsController < ApplicationController
  wrap_parameters format: []

  def index
    apartments = Apartment.all
    render json: apartments, include: [:tenants, :leases]
  end

  def create
    apartment = Apartment.create(apartment_params)
    if apartment.valid?
      render json: apartment, include: [:tenants, :leases], status: :created
    else
      render json: {error: apartment.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def update
    apartment = find_apartment
    apartment.update(apartment_params)
    if apartment.valid?
      render json: apartment, include: [:tenants, :leases], status: :reset_content
    else
      render json: {error: apartment.errors.full_messages}, status: :unprocessable_entity
    end
  end

  def destroy
    apartment = find_apartment
    apartment.destroy
    head :no_content
  end


  private

  def apartment_params
    params.permit(:number)
  end

  def find_apartment
    Apartment.find(params[:id])
  end

end
