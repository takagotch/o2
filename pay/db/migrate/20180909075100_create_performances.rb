class CreatePerformances < ActiveRecord::Migration[5.0]
  def change
    create_table :performances do |t|
      t.references :events, foreign_key: ture
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps
    end
  end

end


