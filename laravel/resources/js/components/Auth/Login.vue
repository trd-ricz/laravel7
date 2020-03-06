<template>
  <div style="height: 100%;">
   <label>Username</label><input type="text" v-model="$store.state.auth.username">
   <label>Password</label><input type="password" v-model="$store.state.auth.password">
   <input type="submit" @click="loginSubmit">
  </div>
</template>
<script>
import { mapState, mapMutations, mapActions, mapGetters } from 'vuex'
export default {
  components: {
    
  },
  data: function() {
    return {
      
    };
  },
  props: {
   
  },
  beforeMount() {
  },
  computed: {
    
  },
  mounted() {
    
  },

  beforeDestroy() {},

  methods: {
   ...mapActions('auth/',[
    'Authenticate',
  ]),
   loginSubmit(){
     this.Authenticate()
   },
    
    
  }
};
</script>

<style scoped>

</style>