class AddStatusToIdea < ActiveRecord::Migration
  def change
    add_column :ideas, :status, :string
  end
end
