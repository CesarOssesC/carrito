class AgregarColumnaCategoriaCategorias < ActiveRecord::Migration[6.1]
  def change
    add_column :categorias, :categoria, :string
  end
end
