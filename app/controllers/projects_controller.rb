class ProjectsController < ApplicationController
  before_action :get_project, :only => [ :edit, :update, :destroy, :upvote, :downvote]

  MAX_VOTES = 3

  def create
    @hackday = Hackday.find_by(params[:id])
    @project = @hackday.projects.build(project_params)

    if @project.save
      create_votes_cookie
      redirect_to @hackday
    else
      @projects = @hackday.projects.where(:hackday_id => @hackday.id)
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

  def destroy
    flash[:danger] = "Could not delete project" unless @project.destroy
    redirect_to request.referrer || hackdays_url
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
    if user_votes.between(0, MAX_VOTES-1) && @project.votes > 0
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

    def get_project
      @project = Project.find(params[:id])
    end

    def create_votes_cookie
      cookies["#{@project.hackday.id}_votes"][@project.id] = 0 
    end

    def user_votes
      cookies["#{@project.hackday.id}_votes"][@project.id].to_i
    end

    def set_votes(vote)
      cookies["#{@project.hackday.id}_votes"][@project.id] = vote
    end
end
