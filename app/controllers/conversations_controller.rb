class ConversationsController < ApplicationController
  before_action :get_conversation, except: :index
  before_action :check_paticipating!, except: :index

  def index
    @conversations = Conversation.participating(current_user).order('updated_at DESC')
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    redirect_to conversation_path(@conversation) and return if @conversation
    @personal_message = current_user.personal_messages.build
  end

  def show
    @personal_message = PersonalMessage.new
  end

  private

  def get_conversation
    @conversation = Conversation.find_by id: params[:id]
  end

  def check_paticipating!
    redirect_to root_path unless @conversation && @conversation.participates?(current_user)
  end
end
