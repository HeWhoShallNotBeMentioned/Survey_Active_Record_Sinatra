class AddTables < ActiveRecord::Migration
  def change
    create_table(:surveys) do |t|
      t.column(:title, :varchar)

      t.timestamps(null: true)
    end

    create_table(:questions) do |t|
      t.column(:survey_id, :integer)
      t.column(:question, :varchar)

      t.timestamps(null: true)
    end

    create_table(:answers) do |t|
      t.column(:question_id, :integer)
      t.column(:answer, :varchar)

      t.timestamps(null: true)
    end
  end
end
