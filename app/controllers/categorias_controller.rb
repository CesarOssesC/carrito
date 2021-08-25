class CategoriasController < ApplicationController
    def index
        @lista_categorias = Categoria.select(:id, :categoria).order(id: :asc)
    end

    def crear
        @categoria_nueva = Categoria.new
    end

    def guardar
        @categoria_nueva = Categoria.new(categoria_params)

        if @categoria_nueva.save
            redirect_to action: :index
        else
            render :crear
        end
    end

    def mostrar

    end

    def editar

    end

    def actualizar

    end

    def eliminar

    end

    private

    def categoria_params
        params.require(:categoria).permit(:categoria)
    end

end
