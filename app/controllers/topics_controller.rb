class TopicsController < ApplicationController
  before_action :set_topic, only: [:show, :edit, :update, :destroy, :like_it, :dislike_it]

  # GET /topics
  def index
    @topics = Topic.all.order('like_counter DESC').includes(:user).paginate(:page => params[:page], :per_page => 5)

  end

  # GET /topics/1
  def show

    @plus=@topic.answers.where(plus: true).order('like_counter DESC').includes(:user)
    @minus=@topic.answers.where(plus: false).order('like_counter DESC').includes(:user)

  end

  # GET /topics/new
  def new
    @topic = Topic.new(user_id: current_user.id)
  end

  # GET /topics/1/edit
  def edit
    authorize! :edit, @topic
  end

  # POST /topics
  def create
    @topic = Topic.new(topic_params)
    @topic.user_id=current_user.id
    @topic.user_email=current_user.email;
    if @topic.save
      redirect_to @topic, notice: 'Topic was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /topics/1
  def update
    if authorize! :update, @topic
        if @topic.update(topic_params)
          redirect_to @topic, notice: 'Topic was successfully updated.'
        else
          render :edit
        end
    else
      redirect_to @topic
    end
  end

  # DELETE /topics/1
  def destroy
    authorize! :destroy, @topic
    redirect_to topics_url, notice: 'Topic was successfully destroyed.'
  end

  #PUT topics/:id/like_it
  def like_it
   # @topic.update(like_counter: @topic.like_counter+1)
    current_user.change_like @topic
    render json: {like: "+1"}
    #redirect_to :back
  end



   private
    # Use callbacks to share common setup or constraints between actions.
    def set_topic
      @topic = Topic.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def topic_params

      params.require(:topic).permit(:content, :like_counter, :user_id)
    end


end
