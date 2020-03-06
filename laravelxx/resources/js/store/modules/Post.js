const Posts = {

  namespaced : true,

  state: {
    count: 0,
    post : []
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

  },
  getters: {
    getPostById: (state) => (id) => {
        return state.post.find(post => post.row_id === id)
      } 
   },
}
export default Posts