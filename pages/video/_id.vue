<template>
  <v-container>
    <v-row justify="center" align="center">
      <div>
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
            :src="videoId"
            frameborder="0"
            allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
            allowfullscreen
          ></iframe>
        </div>
      </v-col>
    </v-row>
    <v-row>
      {{ creador }}
    </v-row>
    <v-row justify="center">
      <v-rating
        v-model="ratingVideo"
        :half-increments="true"
        :readonly="true"
      ></v-rating>
      <v-btn color="primary" dark @click.stop="dialog = true">
        Calificar
      </v-btn>

      <v-dialog v-model="dialog" max-width="290">
        <v-card>
          <v-card-title class="headline">Ratear</v-card-title>

          <v-card-text>
            <v-rating v-model="ratingUser"></v-rating>
          </v-card-text>

          <v-card-actions>
            <v-spacer></v-spacer>

            <v-btn color="green darken-1" text @click="dialog = false">
              Cancelar
            </v-btn>

            <v-btn color="green darken-1" text @click="handleRating">
              Aceptar
            </v-btn>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-row>
    <v-row justify="center" align="center">
      <v-avatar color="indigo">
        <v-icon dark>mdi-account-circle</v-icon>
      </v-avatar>
      <v-text-field class="m-3" label="Solo" solo :hide-details="true" />
      <v-btn>
        Enviar
      </v-btn>
    </v-row>
    <v-row>
      <v-card :shaped="true">
        <v-card-text>
          <v-container>
            <v-row>
              <v-col>
                <v-avatar color="indigo">
                  <v-icon dark>mdi-account-circle</v-icon>
                </v-avatar>
              </v-col>
              <v-col>
                <v-row>
                  <v-card-title>usuario</v-card-title>
                </v-row>
                <v-row>
                  Lorem ipsumsdfjasfdks jfsj lksafjls adjflasjl
                </v-row>
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
      </v-card>
    </v-row>
  </v-container>
</template>

<script>
  export default {
    async fetch() {
      const url = '/video/' + this.id
      await this.$axios
        .$get(url)
        .then((res) => {
          console.log(res)
          this.videoId = res.url_stream
          this.ratingVideo = res.rating
          this.items = [
            {
              text: res.grado
            },
            {
              text: res.curso
            },
            {
              text: res.unidad
            },
            {
              text: res.titulo
            }
          ]
          this.creador = res.creador_email
        })
        .catch((e) => {
          console.error(e)
        })
    },
    data() {
      return {
        id: this.$route.params.id,
        videoId: '',
        ratingVideo: 0,
        ratingUser: 0,
        dialog: false,
        items: [],
        comments: [],
        creador: ''
      }
    },
    methods: {
      async handleRating() {
        const url = '/videos/rate'
        await this.$axios
          .$put(url, {
            video_id: this.id,
            rating: this.ratingUser,
            usuario_email: this.$auth.user.email
          })
          .then((res) => {
            this.ratingVideo = res
          })
          .catch((e) => {
            console.log(e)
          })
        this.dialog = false
      }
    }
  }
</script>

<style></style>
