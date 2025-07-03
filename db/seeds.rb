# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "csv"

path = File.join([Rails.root, "db/nodes.csv"])
csv = CSV.read(path, converters: :integer)
csv.shift # Remove the header row

# sort the records by the second column, and then by the first column
records = csv.sort do |a, b|
  if (a[1].presence || a[0]) == (b[1].presence || b[0])
    a[0] <=> b[0]
  else
    (a[1].presence || a[0]) <=> (b[1].presence || b[0])
  end
end

records.each do |row|
  # Create a Node record for each row in the CSV file
  Node.create(id: row[0])

  if row[1].blank?
    NodeTreePath.create(descendant_id: row[0], ancestor_id: row[0])
  else
    NodeTreePath.create(descendant_id: row[0], ancestor_id: row[0])

    NodeTreePath.where(descendant_id: row[1]).pluck(:ancestor_id).each do |ancestor_id|
      NodeTreePath.create(descendant_id: row[0], ancestor_id: ancestor_id)
    end
  end
end

# records = csv.sort { |a,b|
#   (a[1].presence || a[0]) <=> (b[1].presence || b[0])
# }

# CSV.foreach(File.join([Rails.root, "db/nodes.csv"]), headers: true) do |row|
#   # Node.create(id: row["id"])
# end

# CSV.foreach(File.join([Rails.root, "db/nodes.csv"]), headers: true) do |row|
#   # Node.create(id: row["id"])
# end
