class RenameIntroductionIdToTointroductionWantlists < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :introduction_id, :introduction
  end
end
