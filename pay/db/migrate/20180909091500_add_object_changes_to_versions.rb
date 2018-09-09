class AddObjectChangesToVersions < ActiveRecord::Migration

  TEXT_BYTES = 1_073_741_823

  def change
    add_column :versions, :object_changes, :text, limit: TEXT_BYTES
  end


end


