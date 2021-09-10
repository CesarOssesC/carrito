class Admin::CategoriasController < Admin::AdminController

    before_action :asignar_categoria, only: [:mostrar, :editar, :actualizar, :eliminar]

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
        if @categoria_nueva.update(categoria_params)
            redirect_to action: :index
        else
            render :editar
        end
    end

    def eliminar
        @categoria_nueva.destroy
        redirect_to action: :index
    end

    

    private

    def categoria_params
        params.require(:categoria).permit(:categoria)
    end

    def asignar_categoria
        @categoria_nueva = Categoria.find(params[:id])
    end

end
