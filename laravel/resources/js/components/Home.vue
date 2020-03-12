<template>
  <div style="height: 100%;">
   <h3>TOP SECTION</h3>
   <p>There are <i>{{count}}</i> Post.</p>
   <input type="text" v-model="$store.state.posts.apiToken">
   <button @click="generateApiToken"> Generate Token</button>
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
    count () {
        return this.$store.state.posts.count
      },
  },
  mounted() {
    
  },

  beforeDestroy() {},

  methods: {
   ...mapActions('posts/',[
	    'generateApiToken',
	 ]),
    
    
  }
};
</script>

<style scoped>

</style>