<template>
  <v-app>
    <NavBar />
    <nuxt class="mt-15" />
  </v-app>
</template>

<script>
  import NavBar from '~/components/NavBar'

  export default {
    components: {
      NavBar
    }
  }
</script>
