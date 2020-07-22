<template>
  <v-container>
    <h1 class="text-center mb-5">Notificaciones</h1>
    <v-alert
      v-for="notification in filteredNotifications"
      :key="notification.key"
      type="warning"
    >
      <nuxt-link :to="'/video/' + notification.video_id">
        El usuario con email: {{ notification.profesor_email }} ha subido el
        video: {{ notification.video_nombre }}
      </nuxt-link>
    </v-alert>
  </v-container>
</template>

<script>
  export default {
    async fetch() {
      const url = '/notif/' + this.$auth.user.email
      await this.$axios
        .$get(url)
        .then((res) => {
          this.notifications = res
          console.log(this.notifications)
        })
        .catch((e) => {
          console.log(e)
        })
    },
    data() {
      return {
        notifications: []
      }
    },
    computed: {
      filteredNotifications() {
        return this.notifications.filter(
          (notification) => notification.read === true
        )
      }
    }
  }
</script>
