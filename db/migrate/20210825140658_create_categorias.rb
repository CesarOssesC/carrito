class CreateCategorias < ActiveRecord::Migration[6.1]
  def change
    create_table :categorias do |t|

      t.timestamps
    end
  end
end
