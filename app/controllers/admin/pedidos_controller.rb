class Admin::PedidosController < Admin::AdminController
    

    def listar
        @lista_pedidos = Pedido.select(:codigo, :total, :created_at).order(created_at: :asc)
    end

    def mostrar

    end

    def crear

    end

    def editar

    end

    def guardar

    end

    def actualizar

    end

    def eliminar

    end

    private

    def params_pedidos

    end

end
