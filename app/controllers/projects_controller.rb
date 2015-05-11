class ProjectsController < ApplicationController
  before_action :set_project_and_hackday, :only => [:edit, :update, :destroy, :upvote, :downvote]

  def create
    @hackday = Hackday.find(params[:hackday_id])
    @new_project = @hackday.projects.build(project_params)

    if @new_project.save
      redirect_to @hackday
    else
      @projects = @hackday.projects.where(:hackday_id => @hackday.id)
      @votes = user_votes
      render 'hackdays/show'
    end
  end

  def edit
  end

  def update
    if @project.update_attributes(project_params)
      flash[:success] = "Project updated!"
      redirect_to @project.hackday
    else
      render 'edit'
    end
  end

  def upvote
    if user_votes.between?(1, MAX_VOTES)
      
      if @project.increment!(:votes)
        set_votes user_votes - 1
      else
        flash[:danger] = "Unable to upvote project"
      end
      
    else
      flash[:warning] = "You've run out of votes!"
    end

    redirect_to @project.hackday
  end

  def downvote
    if user_votes.between?(0, MAX_VOTES-1) && @project.votes > 0
      if @project.decrement!(:votes)
        set_votes user_votes + 1
      else
        flash[:danger] = "Unable to downvote project"
      end
    end

    redirect_to @project.hackday
  end

  private
    def project_params
      params.require(:project).permit(:title, :creators)
    end

    def set_project_and_hackday
      @project = Project.find(params[:id])
      @hackday = @project.hackday
    end
end
