class CreateNoteTags < ActiveRecord::Migration[6.0]
  def change
    create_table :note_tags do |t|
      t.references :notes, null: false, foreign_key: true
      t.references :tags, null: false, foreign_key: true
      t.timestamps
    end
    
  end
  add_index :note_tags,[:note_id, :tag_id], unique: true
  
end
