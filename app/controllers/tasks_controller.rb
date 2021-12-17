class TasksController < ApplicationController
  skip_before_action :require_login, only: %w[index show]

  def index
    @tasks = Task.all
  end

  def new
    @task = current_user.tasks.build
  end

  def create
    @task = current_user.tasks.build(task_params)
    if @task.save
      redirect_to tasks_url, success: "タスク[#{@task.name}]を登録しました"
    else
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = current_user.tasks.find(params[:id])
  end

  def update
    @task = current_user.tasks.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_url, success: "タスク[#{@task.name}]を更新しました"
    else
      render :edit
    end
  end

  def destroy
    task = current_user.tasks.find(params[:id])
    task.destroy!
    redirect_to tasks_url, success: "タスク[#{task.name}]を削除しました"
  end

  private

  def task_params
    params.require(:task).permit(:name, :description)
  end
end
