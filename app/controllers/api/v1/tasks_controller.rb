class Api::V1::TasksController < ApplicationController
    before_action :user_exists


    def index
    	completed_tasks = @user.tasks.completed.where(completed :true)
    	pending_tasks = @user.tasks.completed.where(completed :false)
        render json: {
        	completed_tasks: completed_tasks, pending_tasks: pending_tasks
        }
    end

    def create
        task = @user.tasks.build(task_params)
        task.save
        render json: task, status: 201
    end

    def show
        task = @user.tasks.find_by(id: params[:id])
        unless task
            render json: { error: "task not found"}, status: 404
            return
        end
        render json: task
    end

    def complete
        task = @user.tasks.find_by(id: params[:id])
        unless task
            render json: { :error => "task not found"}, status: 404
            return
        end
        task.complete! 
        task.save
        render json: task
    end


    private

    def task_params
        params.require(:task).permit(:name, :due_date)
    end


    def user_exists
      @user = User.find_by(id: params[:user_id])
        unless @user
            render json: { error: "user not found"}, status: 404
            return
        end 
    end



end