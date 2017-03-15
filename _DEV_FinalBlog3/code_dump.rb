
has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100#" },
    :default_url => "/images/:style/missing.png",
    :url  => ":s3_domain_url",
    :path => "public/avatars/:id/:style_:basename.:extension",
    :storage => :fog,
    :fog_credentials => {
        provider: 'AWS',
        aws_access_key_id: ENV["AWS_ACCESS_KEY_ID"],
        aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"]
    },
    fog_directory: "rails-demo-env"
validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/



<div class="field">
  <%= f.label :fname %><br />
  <%= f.text_field :fname, autofocus: true %>
</div>
<div class="field">
  <%= f.label :lname %><br />
  <%= f.text_field :lname, autofocus: true %>
</div>
<div class="field">
  <%= f.label :username %><br />
  <%= f.text_field :username, autofocus: true %>
</div>
<div class="field">
  <%= f.label :email %><br />
  <%= f.email_field :email, autofocus: true %>
</div>
<div class="field">
  <%= f.label :password %>
  <% if @minimum_password_length %>
  <em>(<%= @minimum_password_length %> characters minimum)</em>
  <% end %><br />
  <%= f.password_field :password, autocomplete: "off" %>
</div>
<div class="field">
  <%= f.label :password_confirmation %><br />
  <%= f.password_field :password_confirmation, autocomplete: "off" %>
</div>
<div class="actions">
  <%= f.submit "Sign up" %>
</div>


class StatesController < ApplicationController
    # after_action :update_state

    @ORDER_STATES = ["unplaced", "submitted", "processing", "shipped", "completed", "deleted"]

    def init
        puts "******* init *******"
        @state_index = 0
        @STATE = @ORDER_STATES[@state_index]
        render :init
    end

    def place_order
        puts "******* place_order *******"
        @state_index = 1
        @STATE = @ORDER_STATES[@state_index]
        render :init
    end

    def cancel_order
        puts "******* cancel_order *******"
        @state_index = 0
        @STATE = @ORDER_STATES[@state_index]
        render :init
    end

    def update_state
        # puts "******* update_state *******"
        # if !@state_index
        #     @state_index = 0
        # end
        # @STATE = @ORDER_STATES[@state_index]
        # render :init
    end

end




<%= link_to "New Comment", {:controller => "comment", :action => "new", :post_id => @post.id }%>

<%= link_to 'New Comment', new_comment_path(@post, @user) %>


  <div class="field">
    <%= f.label :user_id %><br />
    <%= f.number_field :user_id %>
  </div>
  <div class="field">
    <%= f.label :title %><br />
    <%= f.text_field :title %>
  </div>
  <div class="field">
    <%= f.label :content %><br />
    <%= f.text_field :content %>
  </div>
  <div class="actions">
    <%= f.submit %>
  </div>



<!-- <%=# link_to post.title, user_post_path(user_id:session[:user_id], id: post.id) %> -->
<!-- <%=# post.content %> -->

@bc = User.find(1)
puts " ** @bc: #{@bc}"
puts " ** @bc.posts: #{@bc.posts}"
puts " ** @bc.comments: #{@bc.comments}"
puts " ** @bc.comments.find(9): #{@bc.comments.find(9)}"
puts " ** @bc.comments.where(post_id: 4): #{@bc.comments.where(post_id: 4)}"
puts " ** @bc.posts.exists?(id: 5): #{@bc.posts.exists?(id: 5)}"
puts " ** @bc.posts.exists?(id: 50): #{@bc.posts.exists?(id: 50)}"
puts " ** @bc.posts.exists?(title: 'First Post'): #{@bc.posts.exists?(title: 'First Post')}"
puts " ** @bc.posts.exists?(title: 'Third Post'): #{@bc.posts.exists?(title: 'Third Post')}"
