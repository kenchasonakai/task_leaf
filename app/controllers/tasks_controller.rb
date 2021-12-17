class TasksController < ApplicationController
  skip_before_action :require_login

def index
  @tasks = Task.all.includes(:user)
end

def new
  @task = current_user.tasks.build
end

  def create
    @task = Task.new(task_params)
    @task.user_id = current_user.id
    if @task.save
      redirect_to tasks_url, success: "タスク[#{@task.name}]を登録しました"
    else
      flash.now[:danger] = 'タスクの作成に失敗しました'
      render :new
    end
  end

  def show
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    @task = Task.find(params[:id])
    if @task.update(task_params)
      redirect_to tasks_url, success: "タスク[#{@task.name}]を更新しました"
    else
      flash.now[:danger] = 'タスクの更新に失敗しました'
      render :edit
    end
  end

def destroy
  task = Task.find(params[:id])
  task.destroy!
  redirect_to tasks_url, success: "タスク[#{task.name}]を削除しました"
end

private

def task_params
  params.require(:task).permit(:name, :description)
end
end
