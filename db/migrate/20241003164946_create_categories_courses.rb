class CreateCategoriesCourses < ActiveRecord::Migration[7.1]
  def change
    create_table :categories_courses do |t|

      t.timestamps
    end
  end
end
