<template>
  <v-row justify="center">
    <v-col md="10">
      <v-expansion-panels popout>
        <v-expansion-panel v-for="(grado_object, grado) in data" :key="grado">
          <v-expansion-panel-header>
            {{ grado }}
          </v-expansion-panel-header>
          <v-expansion-panel-content>
            <v-expansion-panels popout>
              <v-expansion-panel
                v-for="(curso_object, curso) in grado_object"
                :key="curso"
              >
                <v-expansion-panel-header>
                  {{ curso }}
                </v-expansion-panel-header>
                <v-expansion-panel-content>
                  <v-expansion-panels popout>
                    <v-expansion-panel
                      v-for="unidad in curso_object"
                      :key="unidad.nombre"
                    >
                      <v-expansion-panel-header @click="getVideos(unidad.id)">
                        {{ unidad.nombre }}
                      </v-expansion-panel-header>
                      <v-expansion-panel-content>
                        <v-row>
                          <v-card
                            v-for="(video, index) in videos"
                            :key="video.id"
                            class="mx-auto my-12"
                            max-width="374"
                            :to="'/video/' + video_id[index]"
                          >
                            <v-img
                              height="250"
                              :src="
                                'https://img.youtube.com/vi/' +
                                  video_id[index] +
                                  '/0.jpg'
                              "
                            ></v-img>

                            <v-card-title>{{ video.titulo }}</v-card-title>

                            <v-card-text>
                              <v-row align="center" class="mx-0">
                                <v-rating
                                  :value="4.5"
                                  color="amber"
                                  dense
                                  half-increments
                                  readonly
                                  size="14"
                                ></v-rating>

                                <div class="grey--text ml-4">
                                  {{ video.rating }}
                                </div>
                              </v-row>

                              <div>
                                {{ video.titulo }}
                              </div>
                            </v-card-text>

                            <v-divider class="mx-4"></v-divider>

                            <v-card-actions>
                              <v-btn color="deep-purple lighten-2" text>
                                Guardar
                              </v-btn>
                            </v-card-actions>
                          </v-card>
                        </v-row>
                      </v-expansion-panel-content>
                    </v-expansion-panel>
                  </v-expansion-panels>
                </v-expansion-panel-content>
              </v-expansion-panel>
            </v-expansion-panels>
          </v-expansion-panel-content>
        </v-expansion-panel>
      </v-expansion-panels>
    </v-col>
  </v-row>
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
        data: null,
        videos: null
      }
    },
    computed: {
      video_id() {
        return this.videos.map((video) => {
          return video.url_stream.substr(video.url_stream.length - 11)
        })
      }
    },
    methods: {
      async getVideos(id) {
        const url = '/unit_videos/' + id
        console.log('getVideos')
        await this.$axios
          .$get(url)
          .then((response) => {
            // console.log(response)
            this.videos = response
          })
          .catch((e) => {
            console.log(e)
          })
      },
      async onSubmit() {
        const url = '/unidades'
        console.log('onsubmit')
        await this.$axios
          .$get(url)
          .then((response) => {
            // console.log(response)
            this.data = response
          })
          .catch((e) => {
            console.log(e)
          })
      }
    }
  }
</script>

<style></style>
