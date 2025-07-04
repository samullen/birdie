require "test_helper"

class NodesControllerTest < ActionDispatch::IntegrationTest
  describe "GET /nodes/:id/common_ancestors/:node_b_id" do
    it "returns null values if either ID is not found" do
      get common_ancestors_path(id: 1, node_b_id: 2)

      json = JSON.parse(response.body)

      assert response.status == 200
      assert json["root"].nil?
      assert json["lowest_common_ancestor"].nil?
      assert json["depth"].nil?
    end

    it "returns null values if there isn't a common ancestor" do
      root = nodes(:root)
      orphan = nodes(:orphan)

      get common_ancestors_path(id: root.id, node_b_id: orphan.id)

      json = JSON.parse(response.body)

      assert response.status == 200
      assert json["root"].nil?
      assert json["lowest_common_ancestor"].nil?
      assert json["depth"].nil?
    end

    it "returns good data if there is a common ancestor" do
      root = nodes(:root)
      child = nodes(:child)
      grandchild = nodes(:grandchild)

      get common_ancestors_path(id: child.id, node_b_id: grandchild.id)

      json = JSON.parse(response.body)

      assert response.status == 200
      assert json["root"] == root.id
      assert json["lowest_common_ancestor"] == child.id
      assert json["depth"] == 2
    end

    it "returns a node's data if given its ID twice" do
      root = nodes(:root)
      grandchild = nodes(:grandchild)

      get common_ancestors_path(id: grandchild.id, node_b_id: grandchild.id)

      json = JSON.parse(response.body)

      assert response.status == 200
      assert json["root"] == root.id
      assert json["lowest_common_ancestor"] == grandchild.id
      assert json["depth"] == 3
    end
  end
end
