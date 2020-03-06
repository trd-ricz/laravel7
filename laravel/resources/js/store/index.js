import Vue from 'vue'
import Vuex from 'vuex'
import Posts from './modules/Post'

Vue.use(Vuex)

export default new Vuex.Store({
	modules: {
		posts : Posts
	}
  
})
