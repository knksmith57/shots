class InitDb < ActiveRecord::Migration
  def up
    create_table  :images do |t|
      t.string    :image_id
      t.string    :title
      t.string    :caption
      t.string    :extension
      t.datetime  :created_at
      t.datetime  :last_accessed_at
    end
  end

  def up
    create_table :tokens do |t|
      t.string    :token_id
      t.datetime  :expires_at
      t.datetime  :last_accessed_at
    end
  end
end
