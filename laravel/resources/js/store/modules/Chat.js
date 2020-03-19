const Chat = {

  namespaced : true,

  state: {
   message : "",
   author : "",
   chatData : [],
   frontUrl : 'http://laravel7.localhost/',
   skip : 1,
   whisper : false
    
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
   },
   INC_SKIP(state,pl){
     state.skip++
   },
   CONCAT_MESSAGES(state,pl){
     
     state.chatData = JSON.parse(pl).concat(state.chatData)
     console.log(state.chatData)
   },
   DECREMENT_SKIP(state, pl){
     state.skip--
   },
   WHISPER(state, pl){
    state.whisper = pl
   },

  },
  actions : {
   
   sendMessage(context, pl){
    
    let url = 'api/chat-broadcaster'
     axios.defaults.headers.common = { 'Authorization': 'Bearer ' +context.rootState.posts.apiToken }
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
    context.commit("SAVE_AUTHOR",context.state.author)
   },
   showMore(context,pl){
    let url = 'api/chat-show-more'
    axios.defaults.headers.common = { 'Authorization': 'Bearer ' +context.rootState.posts.apiToken }
    axios.post(
      `${context.state.frontUrl}${url}`, {skip : context.state.skip}
    ).then( (response) => {
      context.commit("CONCAT_MESSAGES",response.data.value)
      context.commit("INC_SKIP")
    }).catch( e => {
      context.commit("DECREMENT_SKIP")
    })
   },
   isTyping(context,pl) {
    console.log(pl)
    if(!pl){
     context.commit("WHISPER",false)
     return
    }
    
    setTimeout(function() {
     let url = 'api/chat-whisper'
     axios.defaults.headers.common = { 'Authorization': 'Bearer ' +context.rootState.posts.apiToken }
     axios.post(
       `${context.state.frontUrl}${url}`, {user : context.state.author}
     ).then( (response) => {
       
       context.commit("WHISPER",true)
     }).catch( e => {
     })
     
    }, 300);
  },
  },
  getters: {
   
  },
}
export default Chat