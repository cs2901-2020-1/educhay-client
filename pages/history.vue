<template>
  <v-row justify="center">
    <v-col md="10">
      <!-- <v-expansion-panels popout>
        <v-expansion-panel v-for="(item, i) in 5" :key="i">
          <v-expansion-panel-header>Item</v-expansion-panel-header>
          <v-expansion-panel-content>
            Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
            eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim
            ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut
            aliquip ex ea commodo consequat.
          </v-expansion-panel-content>
        </v-expansion-panel>
      </v-expansion-panels> -->
      <v-row class="maxHeight">
        <v-card
          v-for="(video, index) in videos"
          :key="video.id"
          class="mx-auto my-6"
          width="374"
          :to="'/video/' + video.id"
        >
          <v-img
            height="250"
            :src="'https://img.youtube.com/vi/' + video_id[index] + '/0.jpg'"
          ></v-img>
          <v-card-title>{{ video.titulo }}</v-card-title>
          <v-card-text>
            <v-row align="center" class="mx-0">
              <v-rating
                :value="video.rating"
                color="amber"
                dense
                half-increments
                readonly
                size="14"
              ></v-rating>

              <div class="grey--text ml-4">
                {{ video.rating }}
              </div>
            </v-row>

            <div>
              {{ video.titulo }}
            </div>
          </v-card-text>
        </v-card>
      </v-row>
    </v-col>
  </v-row>
</template>

<script>
  export default {
    async fetch() {
      const url = '/videos/historicos/' + this.$auth.user.email
      await this.$axios
        .$get(url)
        .then((res) => {
          console.log(res)
          this.videos = res
        })
        .catch((e) => {
          console.log(e)
        })
    },
    data() {
      return {
        videos: null
      }
    },
    computed: {
      video_id() {
        return this.videos.map((video) => {
          return video.url_stream.substr(video.url_stream.length - 11)
        })
      }
    }
  }
</script>

<style></style>
