class PostsController < ApplicationController 
  
  before_filter :redirect_to_home, :only => [:index, :show]
  before_filter :force_login
  before_filter :find_topic_and_post, :except => [:index, :new, :create]
  before_filter :can_edit_post, :only => [:edit, :update, :destroy]
  
  def new
  end
  
  def edit
    @posts = Post.find(params[:id])
  end 
    
  def create
    @post = current_user.posts.build(params[:post])
    @topic = Topic.find(params[:post][:topic_id])
    if (@topic.posts << @post) 
      redirect_to topic_path(:id => @topic.id, :page => @topic.last_page, :anchor => 'p' + @post.id.to_s)
    else 
      flash[:notice] = "Posts cannot be blank"
      redirect_to topic_path(@topic)
    end 
  end 

  def update 
    @post.updated_by = current_user.id
    if @post.update_attributes(params[:post]) 
      redirect_to topic_path(:id => @topic.id, :page => @post.page, :anchor => 'p' + @post.id.to_s)
    else 
      render :action => :edit 
    end 
  end 

  def destroy 
    @post.destroy if @topic.posts_count > 1
    redirect_to topic_url(@topic) 
  end 
  
  def quote
    @post.body = "[quote=#{@post.user.login}]#{@post.body}[/quote]"
    render :template => "posts/_new"
  end
    
  def find_topic_and_post
    @post = Post.find(params[:id])
    @topic = Topic.find(@post.topic.id)
    redirect_to topics_url unless @topic
  end 
  
  def can_edit_post
    redirect_to topic_path(@topic) and return false unless admin? || (current_user == @post.user)
  end
    
end
