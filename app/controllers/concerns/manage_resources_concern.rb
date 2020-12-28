module ManageResourcesConcern
  extend ActiveSupport::Concern
  included do

    before_action :set_model
    before_action :set_resource, only: [:show, :edit, :update, :destroy]

    load_and_authorize_resource
    check_authorization

    def index
      @resources_all = @model.accessible_by(current_ability, :read).filterable(params.slice(filter_keys))
      @resources = @resources_all.order(updated_at: :desc).page(params[:page]).per(params[:page_size] ? params[:page_size] : 10)
    end

    def show
    end

    def new
      @resource = @model.new
    end

    def edit
    end

    def create
      @resource = @model.new(resource_params)
      if @resource.save
        flash[:success] = (t 'create_success') + (t @model_name)
        render json: { data: create_success_path }, status: :ok
      else
        render json: { data: @resource.errors.full_messages.first }, status: :unprocessable_entity
      end
    end

    def update
      if @resource.update(resource_params)
        flash[:success] = (t 'update_success') + (t @model_name)
        render json: { data: update_success_path }, status: :ok
      else
        render json: { data: @resource.errors.full_messages.first }, status: :unprocessable_entity
      end
    end

    def destroy
      @resource.destroy
      respond_to do |format|
        flash[:success] = (t 'delete_success') + (t @model_name)
        format.html { redirect_to destroy_success_path, notice: 'Resource was successfully destroyed.' }
        format.json { render json: { data: destroy_success_path } }
      end
    end

    private

    def set_model
      @model = controller_name.classify.constantize
      @model_name = controller_name.titleize
    end

    def set_resource
      @resource = @model.find(params[:id])
    end

    def filter_keys
      []
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

