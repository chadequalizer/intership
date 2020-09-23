class AddKeywordsToTags < ActiveRecord::Migration[6.0]
  def change
    add_column ActsAsTaggableOn.tags_table, :keywords, :string
    add_index(ActsAsTaggableOn.tags_table, :keywords)
  end
end
