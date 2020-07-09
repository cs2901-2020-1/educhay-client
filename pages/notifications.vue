<template>
  <div>
    xd
  </div>
</template>

<script>
  export default {
    async fetch() {
      const url = '/notif/' + this.$auth.user.email
      await this.$axios
        .$post(url)
        .then((res) => {
          console.log(res)
        })
        .catch((e) => {
          console.log(e)
        })
    },
    data() {
      return {
        notifications: []
      }
    }
  }
</script>
