class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :document

      t.timestamps null: false
    end
  end
end
