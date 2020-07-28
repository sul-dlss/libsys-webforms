class CreateUnicornPolicies < ActiveRecord::Migration[5.0]
  def change
    create_table :unicorn_policies do |t|
      t.string :type
      t.integer :policy_num
      t.string :name
      t.string :description
      t.string :shadowed
      t.string :destination

      t.timestamps null: false
    end
  end
end
