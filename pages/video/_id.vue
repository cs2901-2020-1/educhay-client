<template>
  <v-container>
    <v-row>
      <v-col xs="12" sm="12" md="7" align="center" justify="center">
        <div>
          <iframe
            width="560"
            height="315"
            :src="'https://www.youtube.com/embed/' + id"
            frameborder="0"
            allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
            allowfullscreen
          ></iframe>
        </div>
      </v-col>
      <v-col> </v-col>
    </v-row>
    <v-row>
      <div>
        <v-rating v-model="rating"></v-rating>
        <v-btn>Ratear</v-btn>
      </div>
    </v-row>
  </v-container>
</template>

<script>
  export default {
    fetch() {
      console.log(this.$route.params)
      // const url = '/unit_videos/' + this.id
      // await this.$axios
      //   .$get(url)
      //   .then((res) => {
      //     console.log(res)
      //   })
      //   .catch((e) => {
      //     console.error(e)
      //   })
    },
    data() {
      return {
        id: this.$route.params.id,
        rating: 0
      }
    }
  }
</script>

<style></style>
