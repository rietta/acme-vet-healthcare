# frozen_string_literal: true

module Admin
  class MedicationsController < ActionController::Base
    skip_before_action :verify_authenticity_token
    respond_to :json

    def index
      medications = if params[:name].present?
                      Medication.where('name ILIKE ?', params[:name].strip.downcase + '%')
                    else
                      Medication.all
      end
      render(json: medications)
    end

    def show
      render json: Medication.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end

    def create
      medication = Medication.new(medication_params)
      if medication.save
        render json: medication, status: :created
      else
        render json: medication.errors, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end

    def update
      medication = Medication.find(params[:id])
      if medication.update(medication_params)
        render json: medication, status: :accepted
      else
        render json: medication.errors, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end

    def destroy
      medication = Medication.find(params[:id])
      medication.destroy
      head :ok
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end

    private

    def medication_params
      params.permit(:name, :dose_per_kg)
    end
  end
end
