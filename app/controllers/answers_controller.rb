class AnswersController < ApplicationController
    # POST /answers
  def create
    #binding.pry
    @answer = Answer.new(answer_params)
    @answer.user_id=current_user.id
    @answer.user_email=current_user.email
    if @answer.save
      redirect_to :back, notice: 'Answer was successfully created.'
    else
      render :new
    end
  end

  #PUT answers/:id/like_it
  def like_it
    @answer = Answer.find(params[:id])
    #binding.pry
    #@answer.update(like_counter: @answer.like_counter+1)
    current_user.change_like @answer
    render json: {like: "+1"}
  end


  private
    # Only allow a trusted parameter "white list" through.
    def answer_params
      params.require(:answer).permit(:plus, :content, :topic_id, :user_id)
    end
end
