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

  # Create ancestor-child relationships in NodeTreePath for each row
  if row[1].blank?
    NodeTreePath.create(descendant_id: row[0], ancestor_id: row[0])
  else
    NodeTreePath.create(descendant_id: row[0], ancestor_id: row[0])

    NodeTreePath.where(descendant_id: row[1]).pluck(:ancestor_id).each do |ancestor_id|
      NodeTreePath.create(descendant_id: row[0], ancestor_id: ancestor_id)
    end
  end
end
