<template>
  <v-container fluid>
    <v-row justify="space-around" align="start">
      <v-col md="3" align="start" justify="center" class="fixed">
        <div>
          <v-breadcrumbs :items="items" class="text-lg-h6 font-weight-black">
            <template v-slot:divider>
              <v-icon>mdi-chevron-right</v-icon>
            </template>
          </v-breadcrumbs>
        </div>
        <v-list shaped dense>
          <v-subheader class="text-lg-h6 font-weight-black"
            >Unidades dentro del curso</v-subheader
          >
          <v-list-item-group color="primary">
            <v-list-item v-for="(item, i) in unidades" :key="i">
              <v-list-item-icon>
                <v-icon>mdi-book-open-page-variant</v-icon>
              </v-list-item-icon>
              <v-list-item-content>
                <v-list-item-title
                  class="text-sm-body-2 font-weight-black"
                  v-text="item.nombre"
                ></v-list-item-title>
              </v-list-item-content>
            </v-list-item>
          </v-list-item-group>
        </v-list>
      </v-col>
      <v-col
        xs="12"
        sm="12"
        md="9"
        offset="3"
        align="center"
        justify="center"
        class="p-3"
      >
        <template v-if="isYoutube">
          <iframe
            width="100%"
            height="800px"
            :src="videoId"
            frameborder="0"
            allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
            allowfullscreen
          />
        </template>
        <template v-else>
          <video-player :options="videoOptions" />
        </template>
        <b-row align-h="between" class="video-title p-3">
          <div class="text-lg-h4 font-weight-black">
            {{ title }}
          </div>
          <div>
            <div v-if="!isYoutube">
              <a :href="urlUpload"></a>
            </div>
            <v-btn color="#b0dee4" @click.stop="dialog = true">
              Calificar
            </v-btn>
          </div>
        </b-row>
        <b-row align-h="between" align-v="start" class="video-author p-3">
          <div class="p-3">
            <b-row>
              {{ creador_nombre }}
              {{ creador }}
            </b-row>
            <br />
            <b-row align-h="start">
              <p>{{ descripcion }}</p>
            </b-row>
          </div>
          <b-row align-v="center" align-h="end">
            <v-rating
              v-model="ratingVideo"
              half-increments
              background-color="orange lighten-3"
              color="orange"
              :readonly="true"
            ></v-rating>
            <div class="font-weight-black m-3 text-md-body-1">
              ({{ views }}) vistas
            </div>

            <v-dialog v-model="dialog" max-width="290">
              <v-card>
                <v-card-title class="headline">Calificar</v-card-title>

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
          </b-row>
        </b-row>
        <v-row justify="center" class="p-3">
          <v-col>
            <v-row>
              <h2 class="bebas t-green t-4">Comentarios:</h2>
            </v-row>
            <v-row justify="center" align="center">
              <!-- <v-avatar color="indigo">
                <v-icon dark>mdi-account-circle</v-icon>
              </v-avatar> -->
              <v-text-field
                v-model="comment"
                class="m-3"
                label="Ingresa un comentario..."
                solo
                :hide-details="true"
              />
              <b-btn variant="blue" @click="submitComment">
                Enviar
              </b-btn>
            </v-row>
            <v-row
              v-for="comentario in comments"
              :key="comentario.key"
              class="m-2 h-5"
            >
              <v-card :shaped="true" class="w-100" color="rgb(243, 244, 244)">
                <v-card-text class="p-0">
                  <v-container fluid class="p-0">
                    <v-row justify="start" align="center">
                      <v-col md="1">
                        <v-avatar color="indigo" class="ml-7">
                          <v-icon dark>mdi-account-circle</v-icon>
                        </v-avatar>
                      </v-col>
                      <v-col md="10" class="p-3">
                        <v-row justify="space-between" align="center">
                          <v-col>
                            <v-card-title class="p-0"
                              >{{ comentario.nombre }}
                              {{ comentario.apellido }}
                              <v-divider vertical class="pl-1 pr-1">
                              </v-divider>
                              <div class="text-md-body-1">
                                {{ comentario.email }}
                              </div>
                            </v-card-title>
                          </v-col>
                          <v-col md="2">
                            {{
                              $moment(comentario.fecha).format(
                                'DD/MM/YYYY hh:mm'
                              )
                            }}
                          </v-col>
                        </v-row>
                        <v-row class="text-md-body-1 p-2 pl-3">
                          <div class="text-left">
                            {{ comentario.content }}
                          </div>
                        </v-row>
                      </v-col>
                      <v-col
                        v-if="comentario.email === $auth.user.email"
                        md="1"
                        align-self="start"
                        justify-self="end"
                      >
                        <v-icon
                          class="mt-5"
                          @click="deleteComment(comentario.comment_id)"
                          >mdi-close-circle</v-icon
                        >
                      </v-col>
                    </v-row>
                  </v-container>
                </v-card-text>
              </v-card>
            </v-row>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>
<script src="https://cdn.jsdelivr.net/npm/jdenticon@2.2.0" async></script>
<script>
  import VideoPlayer from '@/components/VideoPlayer.vue'
  import awsvideoconfig from '~/src/aws-video-exports'

  export default {
    components: {
      VideoPlayer
    },
    /*     created() {
  this.$loadScript("https://cdn.jsdelivr.net/npm/jdenticon@2.2.0")
    .then(() => {
      this.initiateMapQuest()
    })
    .catch(() => {
      // Failed to fetch script
    })
}, */
    async fetch() {
      console.log('el id')
      let url = '/video/update'
      await this.$axios
        .$put(url, {
          id: this.id,
          user_email: this.$auth.user.email
        })
        .then((res) => {
          console.log('el res de unit_videos', res)
          this.isYoutube = !res.url_stream.includes('amazon')
          this.comments = res.comments
          this.videoId = res.url_stream
          this.urlUpload = res.url_download
          this.ratingVideo = res.rating
          this.views = res.views
          this.title = res.titulo
          this.descripcion = res.descripcion
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
          this.creador_nombre = res.creador_nombre + ' ' + res.creador_apellido
          if (!this.isYoutube) {
            let awsId = this.videoId
              .split('/')
              .slice(2)
              .join()
            awsId = awsId.split('.')
            awsId.pop()
            awsId = awsId.join('.')
            console.log(awsId)
            /* this.videoOptions.sources.src =
              'https://' +
              awsvideoconfig.awsOutputVideo +
              '/1594190757035-2020-04-17_15-03-58/1594190757035-2020-04-17_15-03-58.m3u8' */
            /* this.videoOptions.sources[0].src =
              'https://educhayvod-dev-output-gf3i00yl.s3.amazonaws.com/1594190757035-2020-04-17_15-03-58/1594190757035-2020-04-17_15-03-58.m3u8' */

            // https://educhayvod-dev-output-gf3i00yl.s3.amazonaws.com/1594277636565-2020-04-17_15-04-51/1594277636565-2020-04-17_15-04-51.m3u8
            this.videoOptions.sources[0].src =
              'https://' +
              awsvideoconfig.awsOutputVideo +
              '/' +
              awsId +
              '/' +
              awsId +
              '.m3u8'
            console.log(this.videoOptions.sources.src)
          }
        })
        .catch((e) => {
          console.error(e)
        })

      url = '/unidades'
      await this.$axios
        .$get(url)
        .then((response) => {
          console.log('el response', response)
          console.log(response[this.items[0].text][this.items[1].text])
          this.unidades = response[this.items[0].text][
            this.items[1].text
          ].splice(0, 17)
          // console.log(this.unidades)
        })
        .catch((e) => {
          console.log(e)
        })
    },
    data() {
      return {
        id: this.$route.params.id,
        videoId: '',
        title: '',
        views: 0,
        ratingVideo: 0,
        ratingUser: 0,
        dialog: false,
        items: [],
        comments: [],
        creador: '',
        descripcion: '',
        creador_nombre: '',
        unidades: {},
        comment: '',
        isYoutube: true,
        videoOptions: {
          autoplay: false,
          controls: true,
          width: 1270,
          height: 830,
          sources: [
            {
              src: '',
              type: 'application/x-mpegURL'
            }
          ]
        }
      }
    },
    watch: {
      sixUnits() {
        return this.unidades.splice(0, 17)
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
            console.log(res)
            this.ratingVideo = res
          })
          .catch((e) => {
            console.log(e)
          })
        this.dialog = false
      },
      async submitComment() {
        let url = '/comments/POST'
        await this.$axios
          .$post(url, {
            creador_email: this.$auth.user.email,
            fecha: Date.now(),
            video_id: this.id,
            content: this.comment
          })
          .then((res) => {
            console.log(res)
          })
          .catch((e) => {
            console.log(e)
          })
        url = '/video'
        await this.$axios
          .post(url, {
            id: this.id,
            user_email: this.$auth.user.email
          })
          .then((res) => {
            console.log(res)
            this.comments = res.data.comments
          })
          .catch((e) => {
            console.log(e)
          })
      },
      async deleteComment(commentId) {
        let url = '/comments/delete'
        await this.$axios
          .$delete(url, {
            data: {
              creador_email: this.$auth.user.email,
              video_id: this.id,
              comment_id: commentId
            }
          })
          .catch((e) => {
            console.log(e)
          })
        url = '/video'
        await this.$axios
          .post(url, {
            id: this.id,
            user_email: this.$auth.user.email
          })
          .then((res) => {
            this.comments = res.data.comments
          })
          .catch((e) => {
            console.log(e)
          })
      }
    }
  }
</script>

<style>
  @import 'node_modules/video.js/dist/video-js.css';

  .fixed {
    position: fixed;
    top: 7%;
    left: 0;
  }
</style>
