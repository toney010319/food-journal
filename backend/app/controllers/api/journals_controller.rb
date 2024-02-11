module Api
class JournalsController < ApplicationController
  before_action :set_user, only: [:create, :show,:index]
   

  def index
    journals = @user.journals.all
    
    breakfast = journals.where(mealtype: "breakfast")
    lunch = journals.where(mealtype: "lunch")
    dinner = journals.where(mealtype: "dinner")

    render json: {breakfast:breakfast, lunch:lunch, dinner:dinner}
  end
  def create
    journal = Journal.new(journal_params)
      
    if journal.save
      render json: journal, status: :ok
    else
      render json: {error: 'Unable to Add meal'}, status: :unprocessable_entity
    end
  end

  def show
   
    journal = @user.journals.find(params[:id])
    render json: journal
  end

  private
  
    def journal_params
      params.permit(:image,:label, :yield,  :mealtype, :user_id, dietlabel:[], digestlabel: [:total, :label], healthlabel: [], ingredientlines: [])
    end

    private
    def set_user
      @user = User.find(params[:user_id])
    end

    # def build_recipe(obj_param)
    #     return_obj= {}

    #     obj_param.each do |item|
    #       return_obj << 
    # end

end
end