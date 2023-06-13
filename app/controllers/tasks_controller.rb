class TasksController < ApplicationController
  before_action :find_task, only: %i[toggle edit update destroy]

  def index
    @tasks = Task.order(created_at: :desc)
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    respond_to do |format|
      if @task.save
        format.html { redirect_to tasks_url, notice: "Task created successfully." }
      else
        format.html { redirect_to tasks_url, alert: "Task not created." }
      end
    end
  end

  def toggle
    @task.update(completed: params[:completed])
  end

  def edit
  end

  def update
    respond_to do |format|
      if @task.update(task_params)
        format.html { redirect_to tasks_url, notice: "Task updated successfully." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: "Task deleted successfully."
  end

  private

  def find_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:description)
  end
end
