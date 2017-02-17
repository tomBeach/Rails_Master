
# User: fname:string lname:string email:string username:string password:string created_at:timestamp updated_at:timestamp
User.destroy_all
User.create([
    { fname:"Bill", lname:"Clinton", email:"wjc@gmail.com", username:"wjc", password:"wjc123" },
    { fname:"George", lname:"Bush", email:"gwb@gmail.com", username:"gwb", password:"gwb123" },
    { fname:"Barak", lname:"Obama", email:"bho@gmail.com", username:"bho", password:"bho123" },
    { fname:"The", lname:"Donald", email:"djt@gmail.com", username:"djt", password:"djt123" }
])

# Post user_id:integer title:string content:text created_at:timestamp updated_at:timestamp
Post.destroy_all
Post.create([
    { user_id:1, title:"First Post", content:"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer nec odio. Praesent libero. Sed cursus ante dapibus diam. Sed nisi. Nulla quis sem at nibh elementum imperdiet. Duis sagittis ipsum. Praesent mauris. Fusce nec tellus sed augue semper porta. Mauris massa. Vestibulum lacinia arcu eget nulla. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Curabitur sodales ligula in libero. Sed dignissim lacinia nunc." },
    { user_id:1, title:"Second Post", content:"Curabitur tortor. Pellentesque nibh. Aenean quam. In scelerisque sem at dolor. Maecenas mattis. Sed convallis tristique sem. Proin ut ligula vel nunc egestas porttitor. Morbi lectus risus, iaculis vel, suscipit quis, luctus non, massa. Fusce ac turpis quis ligula lacinia aliquet. Mauris ipsum. Nulla metus metus, ullamcorper vel, tincidunt sed, euismod in, nibh." },
    { user_id:2, title:"First GWB Post", content:"Mauris ipsum. Nulla metus metus, ullamcorper vel, tincidunt sed, euismod in, nibh. Quisque volutpat condimentum velit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nam nec ante. Sed lacinia, urna non tincidunt mattis, tortor neque adipiscing diam, a cursus ipsum ante quis turpis. Nulla facilisi. Ut fringilla. Suspendisse potenti. Nunc feugiat mi a tellus consequat imperdiet. Vestibulum sapien. Proin quam. Etiam ultrices." },
    { user_id:3, title:"Hope and Change", content:"Suspendisse in justo eu magna luctus suscipit. Sed lectus. Integer euismod lacus luctus magna. Quisque cursus, metus vitae pharetra auctor, sem massa mattis sem, at interdum magna augue eget diam. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Morbi lacinia molestie dui. Praesent blandit dolor. Sed non quam. In vel mi sit amet augue congue elementum. Morbi in ipsum sit amet pede facilisis laoreet. Donec lacus nunc, viverra nec, blandit vel, egestas et, augue. Vestibulum tincidunt malesuada tellus. Ut ultrices ultrices enim. Curabitur sit amet mauris." },
    { user_id:4, title:"You're Fired", content:"Morbi in dui quis est pulvinar ullamcorper. Nulla facilisi. Integer lacinia sollicitudin massa. Cras metus. Sed aliquet risus a tortor. Integer id quam. Morbi mi. Quisque nisl felis, venenatis tristique, dignissim in, ultrices sit amet, augue. Proin sodales libero eget ante. Nulla quam. Aenean laoreet. Vestibulum nisi lectus, commodo ac, facilisis ac, ultricies eu, pede. Ut orci risus, accumsan porttitor, cursus quis, aliquet eget, justo." }
])

# Comment user_id:integer post_id:integer content:text created_at:timestamp updated_at:timestamp
Comment.destroy_all
Comment.create([
    { user_id:2, post_id:1, content:"Vestibulum tincidunt malesuada tellus." },
    { user_id:3, post_id:2, content:"Morbi in dui quis est" },
    { user_id:3, post_id:3, content:"Sed aliquet risus a tortor." },
    { user_id:4, post_id:4, content:"Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos." },
    { user_id:1, post_id:5, content:"Fusce ac turpis quis ligula lacinia aliquet." },
    { user_id:2, post_id:1, content:"In vel mi sit amet augue congue elementum." },
    { user_id:3, post_id:2, content:"Sed cursus ante dapibus diam." },
    { user_id:4, post_id:3, content:"Ut orci risus, accumsan porttitor, cursus quis, aliquet eget, justo." },
    { user_id:1, post_id:4, content:"Integer id quam." },
    { user_id:2, post_id:5, content:"Proin sodales libero eget ante. Nulla quam. Aenean laoreet. Vestibulum nisi lectus, commodo ac, facilisis ac, ultricies eu, pede." }
])
