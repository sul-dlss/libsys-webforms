class AddTodoToEdiInvLine < ActiveRecord::Migration
  def change
    add_column :edi_inv_line, :todo, :string
  end
end
