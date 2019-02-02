class TasksController < ApplicationController
  
  before_action :require_user_logged_in
  before_action :correct_user , only: [:destroy,:update,:show,:edit]

  
  def index
    
    if logged_in?
      @task = current_user.tasks.build  # form_for 用
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
    end
  end

  def show
    @tasks = Task.find(params[:id])
  end

  def new
    @tasks = Task.new
  end


  
   def create
    @tasks = current_user.tasks.build(tasks_params)
    if @tasks.save
      flash[:success] = 'Taskを投稿しました。'
      redirect_to root_url
    else
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'Taskの投稿に失敗しました。'
      render :new
    end
   end
  
  

  def edit
    @tasks = Task.find(params[:id])
  end

  def update
    @tasks = Task.find(params[:id])

    if @tasks.update(tasks_params)
      flash[:success] = 'Task は正常に更新されました'
      redirect_to @tasks
    else
      flash.now[:danger] = 'Task は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @tasks = Task.find(params[:id])
    @tasks.destroy

    flash[:success] = 'Task は正常に削除されました'
    redirect_to tasks_url
  end
  
  
  private

  # Strong Parameter
  def tasks_params
    params.require(:task).permit(:content,:status)
  end

  def correct_user
    @tasks = current_user.tasks.find_by(id: params[:id])
    unless @tasks
      redirect_to root_url
    end
  end  
  
end
