require "test_helper"

class BirdsControllerTest < ActionDispatch::IntegrationTest
  describe "GET /birds" do
    it "returns an empty list if no birds exist for the node_ids provided" do
      get birds_path(), params: {node_id: [9999, 9998]}

      json = JSON.parse(response.body)

      assert response.status == 200
      assert json["bird_ids"].empty?
    end

    it "returns the descendants of the node provided" do
      node = nodes(:root)

      get birds_path(), params: {node_id: [node.id]}

      json = JSON.parse(response.body)
      assert response.status == 200
      assert json["bird_ids"].size == 3
    end

    it "returns 1 if the bird has no descendants" do
      node = nodes(:orphan)

      get birds_path(), params: {node_id: [node.id]}

      json = JSON.parse(response.body)
      assert response.status == 200
      assert json["bird_ids"].size == 1
    end

    it "returns all descendant bird_ids for node_ids provided" do
      root = nodes(:root)
      orphan = nodes(:orphan)

      get birds_path(), params: {node_id: [root.id,orphan.id]}

      json = JSON.parse(response.body)
      assert response.status == 200
      assert json["bird_ids"].size == 4
    end
  end
end
