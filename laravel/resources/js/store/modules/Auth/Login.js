const Posts = {

  namespaced : true,

  state: {
    username : null,
    password : null,
    auth : null
  },
  mutations: {
    SET_AUTH_TOKEN (state, pl){
     state.auth = pl
    }
  },
  actions : {
   Authenticate(context,pl){
    axios.get('/airlock/csrf-cookie').then(response => {
     axios.post('/api/airlock/token',{email : context.state.username, password : context.state.password, device_name: 'spa'}).then(response => {
       context.commit('SET_AUTH_TOKEN', response)
     });
    });
   }

  },
  getters: {
    
   },
}
export default Posts