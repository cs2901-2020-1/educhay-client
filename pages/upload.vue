<template>
  <v-row justify="center" align="center">
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
        apiKey: 'AIzaSyCBnpJSkavwngFfk9Jn9RyfJaUmePyRdkw',
        message: null,
        title: ''
      }
    },
    computed: {
      getId() {
        return this.form.link.substr(this.form.link.length - 11)
      }
    },
    methods: {
      async uploadVideo() {
        const url = '/videos/POST'
        await this.$axios
          .$post(url, {
            creador_email: this.$auth.user.email,
            _unidad: this.form.unidad,
            url_stream:
              'https://www.youtube.com/embed/' +
              this.form.link.substr(this.form.link.length - 11),
            titulo: this.title,
            url_download: ''
          })
          .then((res) => {
            console.log('gaaaa')
          })
          .catch((e) => {
            console.log('geeeee')
          })
      },
      async checkId() {
        console.log(this.form.id)
        const apiKey = 'key=' + this.apiKey
        const part = 'part=snippet'
        const url =
          'https://www.googleapis.com/youtube/v3/videos' +
          '?' +
          apiKey +
          '&' +
          'id=' +
          this.form.link.substr(this.form.link.length - 11) +
          '&' +
          part
        await this.$axios.$get(url).then((res) => {
          console.log(res.items[0].snippet.title)
          if (res.items.length === 0) {
            this.message = 'error'
          } else {
            this.title = res.items[0].snippet.title
            this.message = 'success'
          }
        })
      }
    }
  }
</script>
