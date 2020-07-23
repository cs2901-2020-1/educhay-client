<template>
  <v-row justify="center" class="mt-0 pl-3">
    <v-col md="3" class="colorDarken">
      <v-row justify="center" align="center" class="maxHeight">
        <v-container>
          <v-text-field
            v-model="searchVideo"
            solo
            clearable
            append-icon="mdi-magnify"
            @click:append="handleSearch"
            @click:clear="onSubmit"
          ></v-text-field>
          <v-expansion-panels>
            <v-expansion-panel
              v-for="(grado_object, grado) in data"
              :key="grado"
            >
              <v-expansion-panel-header>
                {{ grado }}
                <template v-slot:actions>
                  <v-icon color="primary">$expand</v-icon>
                </template>
              </v-expansion-panel-header>
              <v-expansion-panel-content>
                <v-expansion-panels>
                  <v-expansion-panel
                    v-for="(curso_object, curso) in grado_object"
                    :key="curso"
                  >
                    <v-expansion-panel-header>
                      {{ curso }}
                      <template v-slot:actions>
                        <v-icon color="primary">$expand</v-icon>
                      </template>
                    </v-expansion-panel-header>
                    <v-expansion-panel-content>
                      <v-expansion-panels>
                        <v-expansion-panel
                          v-for="unidad in curso_object"
                          :key="unidad.nombre"
                        >
                          <v-expansion-panel-header
                            @click="getVideos(unidad.id)"
                          >
                            {{ unidad.nombre }}
                            <template v-slot:actions>
                              <v-icon color="primary">$expand</v-icon>
                            </template>
                          </v-expansion-panel-header>
                        </v-expansion-panel>
                      </v-expansion-panels>
                    </v-expansion-panel-content>
                  </v-expansion-panel>
                </v-expansion-panels>
              </v-expansion-panel-content>
            </v-expansion-panel>
          </v-expansion-panels>
        </v-container>
      </v-row>
    </v-col>
    <v-col md="9">
      <v-row class="maxHeight">
        <v-card
          v-for="(video, index) in videos"
          :key="video.id"
          class="mx-auto my-6"
          width="374"
          :to="'/video/' + video.id"
        >
          <v-img
            height="250"
            :src="'https://img.youtube.com/vi/' + video_id[index] + '/0.jpg'"
          ></v-img>
          <v-card-title>{{ video.titulo }}</v-card-title>
          <v-card-text>
            <v-row align="center" class="mx-0">
              <v-rating
                :value="video.rating"
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
        </v-card>
      </v-row>
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
        videos: null,
        searchVideo: ''
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
            console.log(response)
            this.videos = response.sort((a, b) => b.rating - a.rating)
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
            console.log(response)
            this.data = response
          })
          .catch((e) => {
            console.log(e)
          })
      },
      handleSearch() {
        console.log(this.searchVideo)
        for (const obj1 in this.data) {
          for (const obj2 in this.data[obj1]) {
            for (
              let item = this.data[obj1][obj2].length - 1;
              item >= 0;
              --item
            ) {
              if (
                !this.data[obj1][obj2][item].nombre.includes(this.searchVideo)
              ) {
                console.log(
                  this.data[obj1][obj2][item].nombre,
                  'no incluye',
                  this.searchVideo
                )
                this.data[obj1][obj2].splice(item, 1)
              }
            }
          }
        }
      }
    }
  }
</script>
