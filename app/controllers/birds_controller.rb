class BirdsController < ApplicationController
  def index
    node_ids = node_params[:node_id]

    descendant_ids = NodeTreePath.where(ancestor_id: node_ids).distinct.
      pluck(:descendant_id)

    birds = Bird.where(node_id: descendant_ids)

    render json: { bird_ids: birds.ids }
  end

  private

  def node_params
    params.permit(node_id: [])
  end
end
