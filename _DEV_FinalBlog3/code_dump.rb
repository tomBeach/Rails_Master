
<%= form_for(resource, as: resource_name, url: registration_path(resource_name), html: { method: :put }) do |f| %>
  <%= devise_error_messages! %>

  <div class="form-group">
      <%= f.label :avatar, class: 'col-sm-2 control-label'  %>
      <div class="col-sm-6">
          <%= f.file_field :avatar %>
      </div>
  </div>

  <div class="field">
    <%= f.label :email %><br />
    <%= f.email_field :email, autofocus: true %>
  </div>

  <% if devise_mapping.confirmable? && resource.pending_reconfirmation? %>
    <div>Currently waiting confirmation for: <%= resource.unconfirmed_email %></div>
  <% end %>

  <div class="field">
    <%= f.label :password %> <i>(leave blank if you don't want to change it)</i><br />
    <%= f.password_field :password, autocomplete: "off" %>
    <% if @minimum_password_length %>
      <br />
      <em><%= @minimum_password_length %> characters minimum</em>
    <% end %>
  </div>

  <div class="field">
    <%= f.label :password_confirmation %><br />
    <%= f.password_field :password_confirmation, autocomplete: "off" %>
  </div>

  <div class="field">
    <%= f.label :current_password %> <i>(we need your current password to confirm your changes)</i><br />
    <%= f.password_field :current_password, autocomplete: "off" %>
  </div>

  <div class="actions">
    <%= f.submit "Update" %>
  </div>
<% end %>

<h3>Cancel my account</h3>

<p>Unhappy? <%= button_to "Cancel my account", registration_path(resource_name), data: { confirm: "Are you sure?" }, method: :delete %></p>



<%= form_for(resource, as: resource_name, url: registration_path(resource_name)) do |f| %>
  <%= devise_error_messages! %>

  <div id="user-data">
    <div class="data"><div class="data-label"><%= label(:fname, "firstname") %></div>
        <div class="data-value"><%= f.text_field :fname, autofocus: true %></div></div>
    <div class="data"><div class="data-label"><%= label(:lname, "lastname") %></div>
        <div class="data-value"><%= f.text_field :lname, autofocus: true %></div></div>
    <div class="data"><div class="data-label"><%= label(:email, "email") %></div>
        <div class="data-value"><%= f.text_field :email, autofocus: true %></div></div>
    <div class="data"><div class="data-label"><%= label(:username, "username") %></div>
        <div class="data-value"><%= f.text_field :username, autofocus: true %></div></div>
    <div class="data"><div class="data-label"><%= label(:password, "password") %></div>
        <div class="data-value"><%= f.password_field :password, autocomplete: "off" %>
            <% if @minimum_password_length %>
                <span>(<%= @minimum_password_length %> characters minimum)</span>
            <% end %></div></div>
    <div class="data"><div class="data-label"><%= label(:password_confirmation, "password confirm") %></div>
        <div class="data-value"><%= f.text_field :password_confirmation, autocomplete: "off", autofocus: true %></div></div>
    <div class="data"><%= f.submit "Sign up" %></div>

<% end %>



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
