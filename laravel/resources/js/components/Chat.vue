<template>
  <div>
   <h3>Chat</h3>
   <input placeholder="Your name" type="text" v-model="$store.state.chat.author" @change="saveAuthor">
   <ul style="width:40%;margin-top: 20px;" >
     <button @click="showMore">Show More</button>
     <li v-for="chatDatum in chatData" :style="$store.state.chat.author == chatDatum.author ?
      'text-align:right' : 'text-align:left'">
       <div class="wrapper" :style="$store.state.chat.author == chatDatum.author ?
        'background: #44cae34a; left: 0;' :
        'background: #bababa4a; right: 0;'">
         <p> {{chatDatum.message}} </p>
         <p style="font-size: 10px;"> {{$store.state.chat.author == chatDatum.author ? 'You' : chatDatum.author}} </p>
       </div>
     </li>
      <hr>
    </ul>
   <textarea v-model="$store.state.chat.message" @keydown="isTyping(true)"></textarea>
   <!-- <p v-show="type">{{whisperBy}} Typing...</p> -->
   <button @click="sendMessage"> Send </button>
  </div>
</template>
<script>
import {mapActions} from 'vuex'
export default {
  components: {
   type : false,
   whisperBy : "",
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
   chatData (){
    return this.$store.state.chat.chatData
   },
  },
  mounted() {
   
   window.Echo.channel("laravel_database_chat_message")
   .listen("ChatEvent", e => {this.receiveMessage(e.chat)})
     
  },
  methods: {
   ...mapActions('chat/',[
    'sendMessage',
    'saveAuthor',
    'receiveMessage',
    'showMore',
    'isTyping'
   ]),
  }
};
</script>

<style scoped>
 ul{
  list-style:none;
 }
 .wrapper{
  width:50%;
  padding: 5px 15px;
  display: inline-block;
  position: relative;
  margin : 5px;
  border-radius : 5px;
 }
</style>