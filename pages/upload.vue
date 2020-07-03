<template>
  <v-row justify="center" align="center">
    <!-- <button @click="authenticate().then(loadClient)">
      authorize and load
    </button>
    <button @click="execute()">execute</button> -->
    <v-btn color="rgb(25, 84, 140)" large fab dark>
      <v-icon>mdi-television</v-icon>
    </v-btn>
    <v-dialog v-model="showModal" persistent max-width="600px">
      <template v-slot:activator="{ on, attrs }">
        <v-btn color="primary" dark v-bind="attrs" v-on="on">
          youtube
        </v-btn>
      </template>
      <v-card>
        <v-card-title>
          <span class="headline">Formulario</span>
          <v-spacer />
          <v-icon @click="showModal = false">mdi-window-close</v-icon>
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col>
                <v-text-field
                  v-model="form.link"
                  label="Link"
                  required
                ></v-text-field>
              </v-col>
              <v-col>
                <v-btn @click="checkId">
                  Check
                </v-btn>
              </v-col>
              <v-col>
                <v-text-field
                  v-model="form.unidad"
                  label="Unidad"
                  required
                ></v-text-field>
              </v-col>
            </v-row>
            <v-row v-if="message">
              <v-alert v-if="message === 'success'" type="success">
                Success
              </v-alert>
              <v-alert v-else-if="message === 'error'" type="error">
                Error
              </v-alert>
            </v-row>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer />
          <v-btn color="blue darken-1" text @click="uploadVideo">Enviar</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
  export default {
    auth: false,
    data() {
      return {
        showModal: false,
        form: {
          link: '',
          unidad: ''
        },
        apiKey: 'AIzaSyAMZy4Hg0tcdVkisz6o_BVwJLFWyuM4V_I',
        message: null,
        title: ''
      }
    },
    computed: {
      getId() {
        return this.form.link.substr(this.form.link.length - 11)
      }
    },
    mounted() {
      const extScript = document.createElement('script')
      extScript.setAttribute('src', 'https://apis.google.com/js/api.js')
      document.head.appendChild(extScript)
      /* gapi.load('client:auth2', function() {
        gapi.auth2.init({ client_id: 'YOUR_CLIENT_ID' })
      }) */
    },
    methods: {
      async uploadVideo() {
        const url = '/videos/POST'
        await this.$axios
          .$post(url, {
            creador_email: 'profe@utec.edu.pe',
            _unidad: this.form.unidad,
            url_stream:
              'https://www.youtube.com/embed/' +
              this.form.link.substr(this.form.link.length - 11),
            titulo: this.title,
            url_download: ''
          })
          .then((res) => {
            console.log('correcto')
          })
          .catch((e) => {
            console.log('error')
          })
      },
      async checkId() {
        //  const apiKey = 'key=' + this.data.apiKey
        const apiKey = 'key=' + this.apiKey
        const part = 'part=snippet'
        const id = 'id=' + this.form.link.substr(this.form.link.length - 11)
        const url =
          'https://www.googleapis.com/youtube/v3/videos?' +
          id +
          '&' +
          apiKey +
          '&' +
          part
        await this.$axios.$get(url).then((res) => {
          if (res.pageInfo.totalResults === 0) {
            this.message = 'error'
          } else {
            this.title = res.items[0].snippet.title
            this.message = 'success'
          }
        })
      }
      /* authenticate() {
        return gapi.auth2
          .getAuthInstance()
          .signIn({
            scope:
              'https://www.googleapis.com/auth/youtube https://www.googleapis.com/auth/youtube.force-ssl https://www.googleapis.com/auth/youtube.readonly https://www.googleapis.com/auth/youtubepartner'
          })
          .then(
            function() {
              console.log('Sign-in successful')
            },
            function(err) {
              console.error('Error signing in', err)
            }
          )
      },
      loadClient() {
        gapi.client.setApiKey('AIzaSyAMZy4Hg0tcdVkisz6o_BVwJLFWyuM4V_I')
        return gapi.client
          .load(
            'https://content.googleapis.com/discovery/v1/apis/youtube/v3/rest'
          )
          .then(
            function() {
              console.log('GAPI client loaded for API')
            },
            function(err) {
              console.error('Error loading GAPI client for API', err)
            }
          )
      },
      execute() {
        return gapi.client.youtube.videos.list({}).then(
          function(response) {
            // Handle the results here (response.result has the parsed body).
            console.log('Response', response)
          },
          function(err) {
            console.error('Execute error', err)
          }
        )
      } */
    }
  }
</script>
