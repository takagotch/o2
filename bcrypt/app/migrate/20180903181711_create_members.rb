class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :password_digest, null: false
    end

    add_column :users, :password_digest, :string

  end

end

