class CreateOptions < ActiveRecord::Migration[5.0]
  def change
    create_table :options do |t|
      t.string :area
      t.string :o_key
      t.string :value

      t.timestamps
    end
  end
end
