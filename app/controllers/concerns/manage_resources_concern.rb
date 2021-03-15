module ManageResourcesConcern
  extend ActiveSupport::Concern
  included do

    before_action :set_model
    before_action :set_resource, only: [:show, :edit, :update, :destroy]

    load_and_authorize_resource
    check_authorization

    def index
      @resources_all = @model.accessible_by(current_ability, :read).filterable(filter_params)
      @resources = @resources_all.order(updated_at: :desc).page(params[:page]).per(params[:page_size] ? params[:page_size] : 10)

      respond_to do |format|
        format.html
        format.xlsx
        format.json { render json: index_json }
      end
    end

    def show
      respond_to do |format|
        format.html
        format.json { render json: show_json }
      end
    end

    def new
      @resource = @model.new
    end

    def edit
    end

    def create
      @resource = @model.new(resource_params)
      if @resource.save
        flash[:success] = "#{t 'manage.resources.create_success'} #{@model.model_name.human}"
        render json: create_json, status: :ok
      else
        render json: { data: @resource.errors.full_messages.first }, status: :unprocessable_entity
      end
    end

    def update
      if @resource.update(resource_params)
        flash[:success] = "#{t 'manage.resources.update_success'} #{@model.model_name.human}"
        render json: update_json, status: :ok
      else
        render json: { data: @resource.errors.full_messages.first }, status: :unprocessable_entity
      end
    end

    def destroy
      @resource.destroy
      respond_to do |format|
        flash[:success] = "#{t 'manage.resources.destroy_success'} #{@model.model_name.human}"
        format.html { redirect_to destroy_success_path, notice: 'Resource was successfully destroyed.' }
        format.json { render json: destroy_json }
      end
    end

    private

    def set_model
      @model = controller_name.classify.constantize
    end

    def set_resource
      @resource = @model.find(params[:id])
    end

    def filter_params
      params.slice
    end

    def show_json(resource = @resource)
      { data: resource.as_json }
    end

    def index_json
      { data: show_json(@resources), total: @resources_all.size }
    end

    def create_json
      { data: create_success_path }
    end

    def update_json
      { data: update_success_path }
    end

    def destroy_json
      { data: destroy_success_path }
    end

    def create_success_path
      url_for({ action: :show, id: @resource.id })
    end

    def update_success_path
      url_for({ action: :show, id: @resource.id })
    end

    def destroy_success_path
      url_for({ action: :index })
    end
  end
end

