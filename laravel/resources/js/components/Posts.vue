<template>
  <div style="height: 100%;">
  <h3>POST SECTION </h3>
   <ol>
    <li v-for="post in posts">
      <p> Content : {{post.content}} </p>
      <p> Author : {{post.author}} </p>
      <p> Date : {{post.date}} </p>
      <p> Level : {{post.post_level}} </p>
      <button @click="delPost(post.row_id)">Delete</button>
      <button @click="editPost(post.row_id)">Edit</button>
      <hr>
    </li>
   </ol>
   <p>{{count}}</p>
   <textarea v-model="textValue"></textarea>
   <button v-if="isEdit" @click="edit">Edit</button>
   <button v-else @click="submitPost">Submit</button>
   <button @click="getPostApi">Get Post Api</button>
  </div>
</template>
<script>
import { mapState, mapMutations, mapActions, mapGetters } from 'vuex'
export default {
  components: {
    
  },
  data: function() {
    return {
      textValue : "",
      isEdit : false,
      editId : null,
    };
  },
  props: {
   defaultPosts : Array,
  },
  beforeMount() {
  },
  computed: {
    count () {
      return this.$store.state.posts.count
    },
    posts (){
      return this.$store.state.posts.post
    },
    ...mapGetters('posts/',[
      'getPostById'
    ])
  },
  mounted() {
    /* this.defaultPost(this.defaultPosts)
    this.increment(this.defaultPosts.length) */
  },

  beforeDestroy() {},

  methods: {
    ...mapActions('posts/',[
      'addPost',
      'increment',
      'deletePost',
      'decrement',
      'updatePost',
      'defaultPost',
      'getPostApi',
    ]),

    submitPost(){
      let value = this.textValue
      this.addPost(
      {
        row_id : this.count + 1,
        content : value,
        author : 'Ricsheil',
        date : 'today',
        post_level : null
      })
      this.increment()
      this.textValue = ""
    },
    delPost (id) {
      this.deletePost(id)
      this.decrement()
    },
    editPost(id){
      this.isEdit = true
      let post = this.getPostById(id)
      this.textValue = post.content
      this.editId = post.row_id
      
    },
    edit(){
      this.updatePost({
        value : this.textValue,
        postId : this.editId
      })
    }
  }
};
</script>

<style scoped>

</style>