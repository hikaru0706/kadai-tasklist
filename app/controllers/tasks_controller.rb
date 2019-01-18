class TasksController < ApplicationController
  def index
    @tasks=Task.all
  end

  def show
    @tasks = Task.find(params[:id])
  end

  def new
    @tasks = Task.new
  end

  def create
      @tasks = Task.new(tasks_params)

    if @tasks.save
      flash[:success] = 'Message が正常に投稿されました'
      redirect_to @tasks
    else
      flash.now[:danger] = 'Message が投稿されませんでした'
      render :new
    end
  end

  def edit
    @tasks = Task.find(params[:id])
  end

  def update
  end

  def destroy
  end
  
  
  private

  # Strong Parameter
  def tasks_params
    params.require(:task).permit(:content)
  end
end
