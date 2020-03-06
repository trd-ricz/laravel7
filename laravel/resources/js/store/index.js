import Vue from 'vue'
import Vuex from 'vuex'
import Posts from './modules/Post'
import Auth from './modules/Auth/Login'

Vue.use(Vuex)

export default new Vuex.Store({
	modules: {
		posts : Posts,
		auth : Auth
	}
  
})
