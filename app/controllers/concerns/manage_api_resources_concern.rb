module ManageApiResourcesConcern
  extend ActiveSupport::Concern
  included do
    before_action :set_model
    before_action :set_resource, only: [:show, :update, :destroy]

    load_and_authorize_resource
    check_authorization

    def index
      @resources_all = @model.accessible_by(current_ability, :read).filterable(filter_params)
      @resources = @resources_all.order(index_order_by).page(params[:page]).per(params[:page_size] ? params[:page_size] : 10)
      render json: index_json
    end

    def show
      render json: show_json
    end

    def create
      @resource = @model.new(resource_params)

      if @resource.save
        render json: create_json, status: :created
      else
        render json: { data: @resource.errors.full_messages.first }, status: :unprocessable_entity
      end
    end

    def update
      if @resource.update(resource_params)
        render json: update_json, status: :ok
      else
        render json: { data: @resource.errors.full_messages.first }, status: :unprocessable_entity
      end
    end

    def destroy
      @resource.destroy
      render json: destroy_json, status: :ok
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

    def index_order_by
      @model.table_name + '.updated_at desc'
    end

    def create_json(resource = @resource)
      show_json(resource)
    end

    def update_json(resource = @resource)
      show_json(resource)
    end

    def destroy_json
      { data: 'success' }
    end
  end
end

