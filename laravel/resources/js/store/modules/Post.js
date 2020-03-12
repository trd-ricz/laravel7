const Posts = {

  namespaced : true,

  state: {
    count: 0,
    post : [],
    apiToken : null,
  },
  mutations: {
    increment (state,pl) {
      if(pl){
        state.count+=pl
      }else{
        state.count++
      }

    },
    decrement(state, pl){
      state.count--
    },
    addPost(state,pl){
      state.post.push(pl)
    },
    defaultPost(state, pl){
      state.post = pl
    },
    deletePost(state,pl){
      let newSetOfPost = []
      state.post.forEach ( (value, key) => {
        if(value.row_id == pl){
          state.post.splice(key,1)
        }
      })
    },
    updatePost(state,pl){
      let newSetOfPost = []
      state.post.map( (value) => {
        if(value.row_id == pl.postId){
          value.content = pl.value
        }
      })
    },
    setApiToken(state,pl){
     state.apiToken = pl
    },

  },
  actions : {
    increment (context,pl){
      context.commit('increment', pl)
    },
    addPost(context,pl){
      context.commit('addPost', pl)
    },
    defaultPost(context,pl){
      context.commit('defaultPost',pl)
    },
    deletePost(context, pl) {
      context.commit('deletePost',pl)
    },
    decrement (context, pl){
      context.commit('decrement')
    },
    updatePost(context, pl){
      context.commit('updatePost',pl)
    },
    generateApiToken(context, pl){
      axios.get('/api/generate_api_token' , { headers: { Authorization: 'Bearer '+context.rootState.auth.auth } })
      .then( (response) => {
        context.commit('setApiToken',response.data.value)
      })
    },
    getPostApi(context,pl){
      axios.get('/api/get_api' , { headers: { Authorization: 'Bearer '+context.state.apiToken } })
      .then( (response) => {
        if(!response.data.status){alert(response.data.message); return;}
        console.log(response.data)
        context.commit('defaultPost',response.data.value)
        context.commit('increment', response.data.value.length)
      })
    },

  },
  getters: {
    getPostById: (state) => (id) => {
        return state.post.find(post => post.row_id === id)
      } 
   },
}
export default Posts