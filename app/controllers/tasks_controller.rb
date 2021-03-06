class TasksController < ApplicationController
  # def self.random_time
  #   Time.at(rand * Time.now.to_i)
  # end

  def index
    @tasks = Task.all
  end

  def new
    @task = Task.new
  end

  def create
    a = Task.create(task_params)
    a.save
    redirect_to tasks_path
  end

  def show
    # id = params[:id].to_i <=== only need this when the data is hard corded
    # @task = Task.find(id) <===
    @task = Task.find(params[:id])
  end

  def edit
    @task = Task.find(params[:id])
  end

  def update
    task = Task.find(params[:id])
    task.update_attributes(task_params) #instead of .update_attributes + .save,
    task.save                           #you can use .update

    redirect_to task_path(task) #can be task_path(task.id)

  end

  def destroy
    task = Task.find(params[:id])
    task.destroy
    redirect_to tasks_path #"render :index" works too.
  end

  def complete
  task = Task.find(params[:id])
  task.update(completed_at: Time.now)
  redirect_to tasks_path
  end

  private

  def task_params #strong params
    return params.require(:task).permit(:name, :description, :completed_at, :tools, :tools_how_often)
  end


end
