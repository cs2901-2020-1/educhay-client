<template>
  <v-container>
    <v-row justify="center" align="center" class="maxHeight">
      <!-- <button @click="authenticate().then(loadClient)">
      authorize and load
    </button>
    <button @click="execute()">execute</button> -->
      <v-col xs="12" sm="12" md="6">
        <v-row justify="center" align="center">
          <v-dialog v-model="showUpload" persistent max-width="600px">
            <template v-slot:activator="{ on, attrs }">
              <v-btn
                color="rgb(25, 84, 140)"
                large
                fab
                dark
                v-bind="attrs"
                v-on="on"
              >
                <v-icon>mdi-television</v-icon>
              </v-btn>
            </template>
            <v-card>
              <v-card-title>
                <span class="headline">Subir video local</span>
                <v-spacer />
                <v-icon @click="showUpload = false">mdi-window-close</v-icon>
              </v-card-title>
              <v-card-text>
                <v-container>
                  <v-row>
                    <v-col>
                      <v-text-field
                        v-model="form.title"
                        label="Título"
                        required
                      ></v-text-field>
                      <v-select
                        v-model="form.grado"
                        :items="grados"
                        :rules="[(v) => !!v || 'Debe seleccionar Grado']"
                        label="Grado"
                        required
                        @input="cursosPorGrado"
                      ></v-select>
                      <v-select
                        v-model="form.curso"
                        :items="cursosSelect"
                        :rules="[(v) => !!v || 'Debe seleccionar Curso']"
                        label="Curso"
                        required
                        @input="unidadesPorCurso"
                      ></v-select>
                      <v-select
                        v-model="form.unidad"
                        :items="unidadesSelect"
                        item-text="nombre"
                        :rules="[(v) => !!v || 'Debe seleccionar Unidad']"
                        label="Unidad"
                        required
                      ></v-select>
                      <v-file-input
                        ref="file"
                        id="file"
                        :rules="rules"
                        accept="video/*"
                        v-model="files"
                        color="blue accent-4"
                        counter
                        placeholder="Elegir video"
                        prepend-icon="mdi-video"
                        :show-size="1000"
                        @change="handleFileUpload"
                      >
                        <template v-slot:selection="{ index, text }">
                          <v-chip
                            v-if="index < 2"
                            color="blue accent-4"
                            dark
                            label
                            small
                          >
                            {{ text }}
                          </v-chip>

                          <span
                            v-else-if="index === 2"
                            class="overline grey--text text--darken-3 mx-2"
                          >
                            +{{ files.length - 2 }} File(s)
                          </span>
                        </template>
                      </v-file-input>
                      <v-card-text>
                        <v-row justify="center" align="center">
                          <v-col md="6">
                            <v-subheader class="pl-0">Rating</v-subheader>
                            <v-rating
                              v-model="form.rating"
                              color="yellow darken-3"
                              background-color="grey darken-1"
                              empty-icon="$ratingFull"
                              half-increments
                              hover
                            ></v-rating>
                          </v-col>
                        </v-row>
                      </v-card-text>
                    </v-col>
                  </v-row>
                  <v-row>
                    <v-col offset-md="8">
                      <v-card-actions>
                        <v-spacer />
                        <v-btn color="primary" @click="submitFile"
                          >Enviar</v-btn
                        >
                      </v-card-actions>
                    </v-col>
                  </v-row>
                </v-container>
              </v-card-text>
            </v-card>
          </v-dialog>
        </v-row>
      </v-col>
      <v-col xs="12" sm="12" md="6">
        <v-row justify="center" align="center">
          <v-dialog v-model="showModal" persistent max-width="600px">
            <template v-slot:activator="{ on, attrs }">
              <v-btn color="error" dark v-bind="attrs" v-on="on">
                youtube
              </v-btn>
            </template>
            <v-card>
              <v-card-title>
                <span class="headline">Ingresar video de YouTube</span>
                <v-spacer />
                <v-icon @click="showModal = false">mdi-window-close</v-icon>
              </v-card-title>
              <v-card-text>
                <v-container>
                  <v-row>
                    <v-col>
                      <v-row>
                        <v-text-field
                          v-model="form.title"
                          label="Título"
                          required
                        ></v-text-field>
                      </v-row>
                      <v-row>
                        <v-text-field
                          v-model="form.link"
                          label="Link"
                          required
                        ></v-text-field>
                        <v-btn @click="checkId">
                          Check
                        </v-btn>
                      </v-row>
                      <v-row>
                        <v-select
                          v-model="form.grado"
                          :items="grados"
                          :rules="[(v) => !!v || 'Debe seleccionar Grado']"
                          label="Grado"
                          required
                          @input="cursosPorGrado"
                        ></v-select>
                      </v-row>
                      <v-row>
                        <v-select
                          v-model="form.curso"
                          :items="cursosSelect"
                          :rules="[(v) => !!v || 'Debe seleccionar Curso']"
                          label="Curso"
                          required
                          @input="unidadesPorCurso"
                        ></v-select>
                      </v-row>
                      <v-row>
                        <v-select
                          v-model="form.unidad"
                          :items="unidadesSelect"
                          item-text="nombre"
                          :rules="[(v) => !!v || 'Debe seleccionar Unidad']"
                          label="Unidad"
                          required
                        ></v-select>
                      </v-row>
                      <v-row>
                        <v-card-text>
                          <v-row justify="center" align="center">
                            <v-col md="6">
                              <v-subheader class="pl-0">Rating</v-subheader>
                              <v-rating
                                v-model="form.rating"
                                color="yellow darken-3"
                                background-color="grey darken-1"
                                empty-icon="$ratingFull"
                                half-increments
                                hover
                              ></v-rating>
                            </v-col>
                          </v-row>
                        </v-card-text>
                      </v-row>
                    </v-col>
                  </v-row>
                  <v-row>
                    <v-col v-if="message">
                      <v-alert v-if="message === 'success'" type="success">
                        Success
                      </v-alert>
                      <v-alert v-else-if="message === 'error'" type="error">
                        Error
                      </v-alert>
                    </v-col>
                    <v-col offset-md="8">
                      <v-card-actions>
                        <v-spacer />
                        <v-btn color="primary" @click="uploadVideo"
                          >Enviar</v-btn
                        >
                      </v-card-actions>
                    </v-col>
                  </v-row>
                </v-container>
              </v-card-text>
            </v-card>
          </v-dialog>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  export default {
    auth: false,
    fetch() {
      console.log('fetching')
      this.onSubmit()
    },
    data() {
      return {
        slide: {
          min: 0,
          max: 5,
          range: [0, 5]
        },
        showModal: false,
        showUpload: false,
        form: {
          grado: '',
          unidad: '',
          curso: '',
          link: '',
          title: '',
          rating: 5
        },
        apiKey: 'AIzaSyAMZy4Hg0tcdVkisz6o_BVwJLFWyuM4V_I',
        message: null,
        title: '',
        cursosSelect: [],
        unidadesSelect: [],
        grados: [],
        cursos: [],
        unidades: [],
        datos: {},
        rules: [
          (value) =>
            !value ||
            value.size < 128000000 ||
            'El video debe pesar maximo 128 MB!'
        ],
        file: '',
        urlUpload: ''
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
      submitFile() {
        const formData = new FormData()
        formData.append('file', this.file)
        this.$axios
          .post('/uploadFile', formData, {
            headers: {
              'Content-Type': 'multipart/form-data'
            }
          })
          .then((res) => {
            this.urlUpload = res
            this.uploadLocalVideo()
          })
          .catch(function() {
            console.log('gee')
          })
      },
      handleFileUpload() {
        this.file = this.$refs.file.files[0]
      },
      cursosPorGrado() {
        let pos = 0
        for (let i = 0; i < this.grados.length; i++) {
          if (this.grados[i] === this.form.grado) {
            pos = i
          }
        }
        this.cursosSelect = Object.keys(this.cursos[pos])
      },
      unidadesPorCurso() {
        let pos = 0
        for (let i = 0; i < this.grados.length; i++) {
          if (this.grados[i] === this.form.grado) {
            pos = i
          }
        }
        this.unidadesSelect = this.cursos[pos][this.form.curso]
      },
      async uploadLocalVideo() {
        const url = '/videos/POST'
        await this.$axios
          .$post(url, {
            creador_email: 'profe@utec.edu.pe',
            _unidad: this.form.unidad.nombre,
            url_stream: this.urlUpload,
            titulo: this.form.title,
            url_download: ''
          })
          .then((res) => {
            console.log('correcto')
          })
          .catch((e) => {
            console.log('error')
          })
      },
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
      },
      async onSubmit() {
        const url = '/unidades'
        await this.$axios
          .$get(url)
          .then((response) => {
            console.log('onSubmit')
            this.grados = Object.keys(response)
            this.cursos = Object.values(response)
          })
          .catch((e) => {
            console.log(e)
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

<style>
  .maxHeight {
    height: 80vh;
  }
</style>
