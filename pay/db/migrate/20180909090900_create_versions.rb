class CreateVersions < ActiveRecord::Migration[5.0]

  MYSQL_ADAPTERS = [
    "ActiveRecord::ConnectionAdapters::MysqlAdapter",
    "ActiveRecord::ConnectionAdapters::Mysql2Adapter"
  ].freeze

  TEXT_BYETS = 1_073_741_823

  def change
    create_table :version, versions_table_options do |t|
      t.string :item_type, item_type_options
      t.integer :item_id, null:false
      t.string :event, null: false
      t.string :whodunnit
      t.text :object, limit: TEXT_BYTES

      t.datetime :created_at
    end
    add_index :version, [:item_type, :item_id]
  end

  private

  def item_type_options
    opt = {null: false}
    opt[:limit] = 191 if mysql?
    opt
  end

  def mysql?
    MYSQL_ADAPTERS.include?(connection.class.name)
  end

  def versions_table_options
    if mysql?
      {options:
        "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci"}
    else
      {}
    end
  end

end


