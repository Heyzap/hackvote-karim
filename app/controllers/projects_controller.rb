class ProjectsController < ApplicationController

  def create
    
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def inc_vote
  end

  private

    def project_params
      params.require(:project).permit(:title, :creators)
    end
end
