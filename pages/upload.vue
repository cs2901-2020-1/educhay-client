<template>
  <!-- <v-container class="maxHeight2 pt-0" fluid>
    <v-row justify="center" align="center" class="min-vh-100">
      <v-col xs="12" sm="12" md="6">
        <v-row justify="center" align="center">
          <h1>
            Subir archivo de video
          </h1>
        </v-row>
        <v-row justify="center" align="center">
          
        </v-row>
      </v-col>
      <v-col xs="12" sm="12" md="6">
        <v-row justify="center" align="center">
          <h1>
            Subir video de Youtube
          </h1>
        </v-row>
        <v-row justify="center" align="center">
          
        </v-row>
      </v-col>
    </v-row>
  </v-container> -->
  <b-container>
    <b-row align-v="center">
      <b-col md="4">
        <b-img class="index1" src="~/assets/img/9.jpg" alt="" fluid></b-img>
      </b-col>
      <b-col md="4">
        <b-row>
          <v-dialog v-model="showUpload" width="60vw" retain-focus="true">
            <template v-slot:activator="{ on, attrs }">
              <div>
                <b-button
                  variant="grey"
                  class="text-uppercase t-5 bebas"
                  v-bind="attrs"
                  v-on="on"
                >
                  <p class="m-0">
                    subir <span class="t-blue">archivo</span> de video
                  </p>
                </b-button>
              </div>
            </template>
            <v-card>
              <v-card-title>
                <span class="headline">Subir video local</span>
                <v-spacer />
                <v-icon @click="borrarModal">mdi-window-close</v-icon>
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
                        id="file"
                        ref="file"
                        v-model="file"
                        :rules="rules"
                        accept="video/*"
                        color="blue accent-4"
                        counter
                        small-chips
                        placeholder="Elegir video"
                        prepend-icon="mdi-video"
                        :show-size="1000"
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
                            +{{ files.length - 2 }} Archivo(s)
                          </span>
                        </template>
                      </v-file-input>
                    </v-col>
                  </v-row>
                  <b-row>
                    <b-col md="3">
                      <b-img
                        class="index1"
                        src="~/assets/img/3.jpg"
                        alt=""
                        fluid
                      ></b-img>
                    </b-col>
                    <b-col md="9">
                      <v-row>
                        <v-card-text>
                          <v-row justify="center" align="center">
                            <v-textarea
                              v-model="form.description"
                              label="Agregar descripción"
                              counter
                              maxlength="200"
                              full-width
                              single-line
                            >
                            </v-textarea>
                          </v-row>
                        </v-card-text>
                      </v-row>
                      <br />
                      <v-row justify="center" align="center">
                        <v-card-actions>
                          <v-btn
                            color="#0bbfe0"
                            class="text-white"
                            @click="submitFile"
                            >Subir</v-btn
                          >
                        </v-card-actions>
                        <v-progress-linear
                          v-show="progress"
                          indeterminate
                          color="cyan"
                          class="mt-3"
                        ></v-progress-linear>
                      </v-row>
                      <v-row v-if="message" align="center" justify="center">
                        <v-alert v-if="message === 'correcto'" type="success">
                          Success
                        </v-alert>
                        <v-alert
                          v-else-if="message === 'incorrecto'"
                          type="error"
                        >
                          Error
                        </v-alert>
                      </v-row>
                    </b-col>
                  </b-row>
                </v-container>
              </v-card-text>
            </v-card>
          </v-dialog>
        </b-row>
        <br />
        <br />
        <b-row>
          <v-dialog v-model="showModal" width="60vw" retain-focus="true">
            <template v-slot:activator="{ on, attrs }">
              <div>
                <b-button
                  variant="grey"
                  class="text-uppercase t-5 bebas"
                  v-bind="attrs"
                  v-on="on"
                >
                  <p class="m-0">
                    subir video de <span class="t-blue">youtube</span>
                  </p>
                </b-button>
              </div>
            </template>
            <v-card>
              <v-card-title>
                <span class="headline">Subir video de YouTube</span>
                <v-spacer />
                <v-icon @click="borrarModal">mdi-window-close</v-icon>
              </v-card-title>
              <v-card-text>
                <v-container class="pr-6 pl-6">
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
                        <!-- <v-btn color="success" @click="checkId">
                          Check
                        </v-btn> -->
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
                    </v-col>
                  </v-row>
                  <b-row>
                    <b-col md="3">
                      <b-img
                        class="index1"
                        src="~/assets/img/3.jpg"
                        alt=""
                        fluid
                      ></b-img>
                    </b-col>
                    <b-col md="9">
                      <v-textarea
                        v-model="form.description"
                        label="Descripcion"
                        counter
                        maxlength="200"
                        full-width
                        single-line
                      >
                      </v-textarea>
                      <br />
                      <v-row justify="center" align="center">
                        <v-card-actions>
                          <v-btn
                            color="#0bbfe0"
                            class="text-white"
                            @click="uploadVideo"
                          >
                            Subir
                          </v-btn>
                        </v-card-actions>
                        <v-progress-linear
                          v-show="progress"
                          indeterminate
                          color="cyan"
                          class="mt-3"
                        ></v-progress-linear>
                      </v-row>
                      <v-row justify="center" align="center">
                        <v-col md="4">
                          <v-row v-if="message" justify="center" align="center">
                            <v-alert
                              v-if="message === 'correcto'"
                              type="success"
                            >
                              Success
                            </v-alert>
                            <v-alert
                              v-else-if="message === 'incorrecto'"
                              type="error"
                            >
                              Error
                            </v-alert>
                          </v-row>
                        </v-col>
                      </v-row>
                    </b-col>
                  </b-row>
                </v-container>
              </v-card-text>
            </v-card>
          </v-dialog>
        </b-row>
      </b-col>
      <b-col md="4">
        <b-img class="index1" src="~/assets/img/10.jpg" alt="" fluid></b-img>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
  export default {
    auth: false,
    fetch() {
      this.onSubmit()
    },
    data() {
      return {
        slide: {
          min: 0,
          max: 5,
          range: [0, 5]
        },
        progress: false,
        showModal: false,
        showUpload: false,
        form: {
          grado: '',
          unidad: '',
          curso: '',
          link: '',
          title: '',
          description: ''
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
        this.progress = true
        this.$axios
          .post('/uploadFile', formData, {
            headers: {
              'Content-Type': 'multipart/form-data'
            }
          })
          .then((res) => {
            console.log('Respuesta local')
            console.log(res)
            console.log(res.data)
            this.urlUpload = res.data
            this.uploadLocalVideo()
          })
          .catch((e) => {
            console.log(e)
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
        console.log(this.$auth.user)
        await this.$axios
          .$post(url, {
            creador_email: this.$auth.user.email,
            _curso: this.form.curso,
            _grado: this.form.grado,
            _unidad: this.form.unidad,
            url_stream: this.urlUpload,
            titulo: this.form.title,
            url_download: this.urlUpload,
            descripcion: 'descripcion'
          })
          .then((res) => {
            console.log('correcto')
            this.progress = false
            this.message = 'correcto'
          })
          .catch((e) => {
            console.log('error')
            this.progress = false
            this.message = 'incorrecto'
          })
      },
      async uploadVideo() {
        const url = '/videos/POST'
        this.progress = true
        const json = {
          creador_email: this.$auth.user.email,
          _curso: this.form.curso,
          _grado: this.form.grado,
          _unidad: this.form.unidad,
          url_stream:
            'https://www.youtube.com/embed/' +
            this.form.link.substr(this.form.link.length - 11),
          titulo: this.form.title,
          url_download: '',
          descripcion: 'descripcion'
        }
        console.log(json)
        await this.$axios
          .$post(url, json)
          .then((res) => {
            this.message = 'correcto'
            console.log('correcto')
            this.progress = false
          })
          .catch((e) => {
            console.log(e)
            this.progress = false
            this.message = 'incorrecto'
          })
      },
      borrarModal() {
        this.showModal = false
        this.form.grado = ''
        this.form.unidad = ''
        this.form.curso = ''
        this.form.link = ''
        this.form.title = ''
        this.showUpload = false
        this.message = ''
        this.progress = false
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
            this.grados = Object.keys(response)
            this.cursos = Object.values(response)
          })
          .catch((e) => {
            console.log(e)
          })
      }
    }
  }
</script>
