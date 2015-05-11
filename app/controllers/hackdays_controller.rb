class HackdaysController < ApplicationController
  include UserVotes

  before_action :set_hackday, :except => [:index, :create]

  def index
    @hackday = Hackday.new
    set_current_and_past_hackdays
  end

  def create
    @hackday = Hackday.new hackday_params

    if @hackday.save
      session["#{@hackday.id}_votes"] = MAX_VOTES
      redirect_to @hackday
    else
      set_current_and_past_hackdays
      render :index
    end
  end

  def edit
    unless @hackday && @hackday.active?
      flash[:warning] = "Cannot edit a non-active hackday"
      redirect_to(request.referrer || root_url)
    end
  end

  def update
    if @hackday && @hackday.update_attributes(hackday_params)
      flash[:success] = "Hackday updated!"
      redirect_to @hackday
    else
      render :edit
    end
  end

  def destroy
    if @hackday && @hackday.destroy
      cookies.delete "#{@hackday.id}_votes"
      redirect_to hackdays_url
    else
      set_show_vars
      render 'hackdays/show'
    end    
  end

  def show
    if @hackday
      set_show_vars
    else
      redirect_to root_url
    end
  end

  def close_voting
    if @hackday && @hackday.update_attribute(:active, false)
      redirect_to @hackday
    else
      flash[:danger] = "Could not close voting"
      set_show_vars
      render 'hackdays/show'
    end
  end

  private
  def hackday_params
    params.require(:hackday).permit(:title, :held_at)
  end

  def set_hackday
    @hackday = Hackday.find_by_id(params[:id].to_i)
  end

  def set_current_and_past_hackdays
    @current_hackday = Hackday.current
    @past_hackdays = Hackday.past
  end

  def set_show_vars
    @new_project = Project.new(:hackday => @hackday)
    @projects = @hackday.projects
    @votes = user_votes
  end

end
