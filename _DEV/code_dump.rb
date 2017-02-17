

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
