<template>
  <div>
    <v-navigation-drawer v-if="sidebar" v-model="sidebar" app>
      <span>
        <v-app-bar-nav-icon class="mt-3 ml-5" @click="sidebar = !sidebar" />
      </span>
      <template v-if="$auth.loggedIn">
        <v-list>
          <v-list-item>
            <v-list-item-icon>
              <v-icon>mdi-logout</v-icon>
            </v-list-item-icon>
          </v-list-item>
        </v-list>
      </template>
      <template v-else>
        <v-list>
          <v-list-item
            v-for="item in menuItems"
            :key="item.title"
            :to="item.path"
          >
            <v-list-item-icon>
              <v-icon>{{ item.icon }}</v-icon>
            </v-list-item-icon>
            <v-list-item-content>{{ item.title }}</v-list-item-content>
          </v-list-item>
        </v-list>
      </template>
    </v-navigation-drawer>

    <v-app-bar color="white">
      <!-- <span class="hidden-sm-and-up"> -->
      <span class="hidden-sm-and-up">
        <v-app-bar-nav-icon @click="sidebar = !sidebar" />
      </span>
      <v-toolbar-title>
        <!-- <nuxt-link to="/" tag="span" style="cursor: pointer;">
          {{ appTitle }}
        </nuxt-link>-->
        <b-img src="~/assets/logo.png" height="50" />
        <small class="align-middle">En colaboración con</small>
        <b-img src="~/assets/logo-utec.png" height="50" />
      </v-toolbar-title>
      <v-spacer />
      <template v-if="$auth.loggedIn">
        <template v-if="$auth.user.is_admin">
          <v-toolbar-items class="hidden-xs-only">
            <v-btn
              v-for="item in menuItemsProfesor"
              :key="item.title"
              text
              :to="item.path"
            >
              <v-icon left dark>{{ item.icon }}</v-icon>
              {{ item.title }}
            </v-btn>
            <v-btn text @click="logOut">
              <v-icon left dark>mdi-account-settings</v-icon>
              {{ this.$auth.user.nombre + ' ' + this.$auth.user.apellido }}
            </v-btn>
            <v-btn text @click="logOut">
              <v-icon left dark>mdi-logout</v-icon>
              Cerrar sesión
            </v-btn>
          </v-toolbar-items>
        </template>
        <template v-else-if="$auth.user.is_profe">
          <v-toolbar-items class="hidden-xs-only">
            <v-btn
              v-for="item in menuItemsProfesor"
              :key="item.title"
              text
              :to="item.path"
            >
              <v-icon left dark>{{ item.icon }}</v-icon>
              {{ item.title }}
            </v-btn>
            <v-btn text @click="logOut">
              <v-icon left dark>mdi-account-settings</v-icon>
              {{ this.$auth.user.nombre + ' ' + this.$auth.user.apellido }}
            </v-btn>
            <v-btn text @click="logOut">
              <v-icon left dark>mdi-logout</v-icon>
              Cerrar sesión
            </v-btn>
          </v-toolbar-items>
        </template>
        <template v-else>
          <v-toolbar-items class="hidden-xs-only">
            <v-btn
              v-for="item in menuItemsLoggedin"
              :key="item.title"
              text
              :to="item.path"
            >
              <v-icon left dark>{{ item.icon }}</v-icon>
              {{ item.title }}
            </v-btn>
            <v-btn text>
              <v-icon left dark>mdi-account-settings</v-icon>
              {{ this.$auth.user.nombre + ' ' + this.$auth.user.apellido }}
            </v-btn>
            <v-btn text @click="logOut">
              <v-icon left dark>mdi-logout</v-icon>
              Cerrar sesión
            </v-btn>
          </v-toolbar-items>
        </template>
      </template>
      <template v-else>
        <v-toolbar-items class="hidden-xs-only">
          <v-btn
            v-for="item in menuItems"
            :key="item.title"
            text
            :to="item.path"
          >
            <v-icon left dark>{{ item.icon }}</v-icon>
            {{ item.title }}
          </v-btn>
        </v-toolbar-items>
      </template>
    </v-app-bar>
  </div>
</template>

<style scoped>
  small {
    font-size: 0.6em;
    font-weight: bold;
  }
</style>

<script>
  export default {
    data() {
      return {
        appTitle: 'Educhay',
        sidebar: false,
        menuItemsLoggedin: [
          { title: 'Home', path: '/', icon: 'mdi-home' },
          { title: 'Videos', path: '/videos', icon: 'mdi-message-video' },
          { title: 'Historial', path: '/history', icon: 'mdi-history' }
        ],
        menuItems: [
          { title: 'Home', path: '/', icon: 'mdi-home' },
          { title: 'Registrarse', path: '/register', icon: 'mdi-face' },
          { title: 'Iniciar sesion', path: '/login', icon: 'mdi-lock-open' }
        ],
        menuItemsProfesor: [
          { title: 'Home', path: '/', icon: 'mdi-home' },
          { title: 'Subir', path: '/upload', icon: 'mdi-file-video' },
          { title: 'Videos', path: '/videos', icon: 'mdi-message-video' },
          { title: 'Historial', path: '/history', icon: 'mdi-history' }
        ],
        menuItemsAdmin: [
          { title: 'Home', path: '/', icon: 'mdi-home' },
          { title: 'Subir', path: '/upload', icon: 'mdi-file-video' },
          { title: 'Videos', path: '/videos', icon: 'mdi-message-video' },
          { title: 'Historial', path: '/history', icon: 'mdi-history' }
        ]
      }
    },
    methods: {
      logOut() {
        this.$auth.logout()
      }
    }
  }
</script>
