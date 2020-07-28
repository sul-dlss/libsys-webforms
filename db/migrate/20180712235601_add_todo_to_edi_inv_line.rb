class AddTodoToEdiInvLine < ActiveRecord::Migration[5.0]
  def change
    add_column :edi_inv_line, :todo, :string
  end
end
