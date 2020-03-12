const Chat = {

  namespaced : true,

  state: {
   message : "",
   author : "",
   chatData : [],
   frontUrl : 'http://laravel7.localhost/',
    
  },
  mutations: {
   SUBMIT_MESSAGE(state,pl){
    console.log('muta',pl)
    state.chatData = pl
//    state.chatData.push(
//      {
//       message : pl.message,
//       author : (pl.author) ? pl.author : "No name"
//      }
//    )
    state.message = ""
   },
   SAVE_AUTHOR(state,pl){
    console.log('author', pl)
    state.author = pl
   }

  },
  actions : {
   
   sendMessage(context, pl){
    
    let url = 'api/chat-broadcaster'
     axios.defaults.headers.common = { 'Authorization': 'Bearer ' +context.rootState.posts.apiToken }
     console.log(context)
     axios.post(
       `${context.state.frontUrl}${url}`, {message : context.state.message, author : context.state.author}
     ).then( (response) => {
        console.log('send success!')
     })
   },
   receiveMessage(context, pl){
     context.commit("SUBMIT_MESSAGE",pl)
   },
   saveAuthor(context, pl){
    console.log("SAVE_AUTHOR",context.state.author)
    context.commit("SAVE_AUTHOR",context.state.author)
   },
    
  },
  getters: {
   
  },
}
export default Chat