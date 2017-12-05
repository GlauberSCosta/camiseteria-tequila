class ProdutosController < ApplicationController

	def index
		@produtos_por_preco = Produto.order(:nome).limit 2
		@produtos_por_nome = Produto.order(:preco).limit 5
	end
	def create
		valores = params.require(:produto).permit :nome, :preco, :descricao, :quantidae, :departamento_id
		@produto = Produto.create valores
		
		if @produto.save

			flash[:notice] = "Produto adicionado com sucesso!"
			redirect_to root_url	
		else
			render :new
		end	
	end

	def new
		@produto = Produto.new
		@departamentos = Departamento.all
	end

	def destroy
		id = params[:id]
		Produto.destroy id
		redirect_to root_url
	end

	def busca

		@nome_a_buscar = params[:nome]
		@produtos = Produto.where "nome like ?", "%#{@nome_a_buscar}%"

	end
end
