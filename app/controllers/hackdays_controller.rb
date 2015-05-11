class HackdaysController < ApplicationController

  def index
    @hackday = Hackday.new
    set_current_and_past_hackdays
  end

  def create
    @hackday = Hackday.new hackday_params
    
    if @hackday.save
      cookies["#{@hackday.id}_votes"] = MAX_VOTES
      redirect_to @hackday
    else
      set_current_and_past_hackdays
      render :index
    end
  end

  def edit
    @hackday = Hackday.find(params[:id])
    unless @hackday.active?
      flash[:warning] = "Cannot edit a non-active hackday"
      redirect_to request.referrer || root_url
    end
  end

  def update
    @hackday = Hackday.find(params[:id])
    if @hackday.update_attributes(hackday_params)
      flash[:success] = "Hackday updated!"
      redirect_to @hackday
    else
      render :edit
    end
  end

  def destroy
    @hackday = Hackday.find(params[:id])
    if @hackday.destroy
      cookies.delete "#{@hackday.id}_votes"
    else
      flash[:warning] = "Cannot remove a non-active hackday"
    end
    redirect_to hackdays_url
  end

  def show
    @hackday = Hackday.find(params[:id])
    @new_project = @hackday.projects.build
    @projects = @hackday.projects.where(:hackday_id => @hackday.id)
    @votes = user_votes
  end

  def close_voting
    @hackday = Hackday.find(params[:id])

    if @hackday.active?
      flash[:danger] = "Could not close voting" unless @hackday.update_attribute(:active, false)
    else
      flash[:warning] = "Hackday is already closed for voting"
    end

    redirect_to @hackday
  end

  private
  def hackday_params
    params.require(:hackday).permit(:title, :held_at)
  end

  def set_current_and_past_hackdays
    @current_hackdays = [Hackday.current]
    @past_hackdays = Hackday.past
  end

end
