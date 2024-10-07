class CreateAnnouncements < ActiveRecord::Migration[8.0]
  def change
    create_table :announcements do |t|
      t.string :title
      t.date :date
      t.string :version
      t.boolean :published, default: true, null: false

      t.timestamps
    end
  end
end
