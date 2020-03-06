import Vue from 'vue'
import store from './store'
import Home from './components/Home'
import Posts from './components/Posts'

require('./bootstrap');

new Vue({
  el: '#app',
  store,
  components: {Home,Posts}
})