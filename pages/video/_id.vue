<template>
  <v-container>
    <v-row justify="center" align="center">
      <div>
        <v-breadcrumbs :items="items">
          <template v-slot:divider>
            <v-icon>mdi-forward</v-icon>
          </template>
        </v-breadcrumbs>

        <v-breadcrumbs :items="items">
          <template v-slot:divider>
            <v-icon>mdi-chevron-right</v-icon>
          </template>
        </v-breadcrumbs>
      </div>
    </v-row>
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
  </v-container>
</template>

<script>
  export default {
    data() {
      return {
        id: this.$route.params.id,
        items: {}
      }
    }
  }
</script>

<style></style>
