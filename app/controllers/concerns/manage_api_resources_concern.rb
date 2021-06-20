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
      render json: { data: set_index_json(@resources), total: @resources_all.size }
    end

    def show
      render json: { data: set_show_json(@resource) }
    end

    def create
      @resource = @model.new(resource_params)

      if @resource.save
        render json: { data: set_create_success_json(@resource) }, status: :created
      else
        render json: { data: @resource.errors.full_messages.first }, status: :unprocessable_entity
      end
    end

    def update
      if @resource.update(resource_params)
        render json: { data: set_update_success_json(@resource) }
      else
        render json: { data: @resource.errors.full_messages.first }, status: :unprocessable_entity
      end
    end

    def destroy
      @resource.destroy
      render json: { data: 'success' }, status: :ok
    end

    private

    def set_show_json(resource)
      resource.as_json
    end

    def set_index_json(resource)
      set_show_json(resource)
    end

    def index_order_by
      'updated_at desc'
    end

    def set_create_success_json(resource)
      set_show_json(resource)
    end

    def set_update_success_json(resource)
      set_show_json(resource)
    end

    def set_model
      @model = controller_name.classify.constantize
      @model_name = controller_name.classify.downcase
    end

    def set_resource
      @resource = @model.find(params[:id])
    end

    def filter_params
      params.slice
    end
  end
end

