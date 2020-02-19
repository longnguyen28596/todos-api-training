class TodosController < ApplicationController
  before_action :load_todo, only: [:show, :update, :destroy]

  def index
    @todos = Todo.all
    render json: @todos, status: 200
  end

  def show
    render json: @todo, status: 200
  end

  def create
    @todo = Todo.create!(todo_params)
    render json: @todo, status: :created
  end

  def update
    @todo.update(todo_params)
    head :no_content
  end

  def destroy
    @todo.destroy
    head :no_content
  end

  private
  def todo_params
    params.require(:todo).permit(:title)
  end

  def load_todo
    @todo = Todo.find params[:id]
  end
end