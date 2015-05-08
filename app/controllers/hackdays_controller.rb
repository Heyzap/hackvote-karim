class HackdaysController < ApplicationController

  def index
    @new_hackday = Hackday.new
    @current_hackdays = Hackday.current
    @past_hackdays = Hackday.past
  end

  def create
    @hackday = Hackday.new hackday_params
    
    if @hackday.save
      redirect_to @hackday
    else
      @hackdays = Hackday.all
      render 'index'
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  def show
    @hackday = Hackday.find_by(params[:id])
  end

  private
  def hackday_params
    params.require(:hackday).permit(:title, :held_at)
  end
end
