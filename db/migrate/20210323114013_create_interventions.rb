class CreateInterventions < ActiveRecord::Migration[5.2]
  def change
    create_table :interventions do |t|
      t.bigint :author
      t.bigint :customer_id
      t.bigint :building_id
      t.bigint :battery_id
      t.bigint :column_id
      t.bigint :elevator_id
      t.bigint :employee_id
      t.timestamp :start_date
      t.timestamp :end_date
      t.string :result
      t.text :report
      t.string :status

      t.timestamps
    end

    # add_foreign_key :from_table, :to_table, column: :column_name
    add_foreign_key :interventions, :employees, column: :author
    add_foreign_key :interventions, :customers, column: :customer_id
    add_foreign_key :interventions, :buildings, column: :building_id
    add_foreign_key :interventions, :batteries, column: :battery_id
    add_foreign_key :interventions, :columns, column: :column_id
    add_foreign_key :interventions, :elevators, column: :elevator_id
    add_foreign_key :interventions, :employees, column: :employee_id
  end
end
