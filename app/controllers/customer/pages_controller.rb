class Customer::PagesController < ApplicationController
  def home
    @trial = Trial.new
  end

  def new
    @trial = Trial.new
  end

  def confirm
    @trial = Trial.new(trial_params)
    if @trial.invalid?
      flash[:alert] = @trial.errors.full_messages.join(", ")
      @trial = Trial.new
      render :new
    end
  end

  def back
    @trial = Trial.new(trial_params)
    render :new
  end

  def create
    @trial = Trial.new(trial_params)
    if @trial.save
      TrialMailer.send_mail(@trial).deliver_now
      redirect_to done_trials_path
    else
      flash[:alert] = @trial.errors.full_messages.join(", ")
      @trial = Trial.new
      render :new
    end
  end

  def done
  end

  def term
  end

  private

  def trial_params
    params.require(:trial).permit(:name, :name_kana, :address, :tell, :email, :participants, :date, :arrival_time, :transportation, :message)
  end

end
