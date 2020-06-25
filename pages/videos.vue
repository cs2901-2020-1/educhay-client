<template>
  <v-row justify="center">
    <v-col md="10">
      <v-expansion-panels popout>
        <v-expansion-panel v-for="grado in grados" :key="grado.grado">
          <v-expansion-panel-header>
            {{ grado.grado }}
          </v-expansion-panel-header>
          <v-expansion-panel-content>
            <v-expansion-panels popout>
              <v-expansion-panel
                v-for="curso in grado.cursos"
                :key="curso.nombre"
              >
                <v-expansion-panel-header>
                  {{ curso.nombre }}
                </v-expansion-panel-header>
                <v-expansion-panel-content>
                  <v-expansion-panels popout>
                    <v-expansion-panel
                      v-for="unidad in curso.unidades"
                      :key="unidad.nombre"
                    >
                      <v-expansion-panel-header>
                        {{ unidad.nombre }}
                      </v-expansion-panel-header>
                      <v-expansion-panel-content>
                        <v-row>
                          <v-card class="mx-auto my-12" max-width="374">
                            <v-img
                              height="250"
                              src="https://content.gnoss.ws/imagenesEnlaces/ab/ab79/ab79ad08-e602-42a9-8c88-56e154b78300/ab79ad08-e602-42a9-8c88-56e154b78300.jpg?1"
                            ></v-img>

                            <v-card-title>{{ unidad.nombre }}</v-card-title>

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

                                <div class="grey--text ml-4">4.5 (413)</div>
                              </v-row>

                              <div>
                                {{ unidad.description }}
                              </div>
                            </v-card-text>

                            <v-divider class="mx-4"></v-divider>

                            <v-card-actions>
                              <v-btn color="deep-purple lighten-2" text>
                                Guardar
                              </v-btn>
                            </v-card-actions>
                          </v-card>
                          <v-card class="mx-auto my-12" max-width="374">
                            <v-img
                              height="250"
                              src="https://content.gnoss.ws/imagenesEnlaces/ab/ab79/ab79ad08-e602-42a9-8c88-56e154b78300/ab79ad08-e602-42a9-8c88-56e154b78300.jpg?1"
                            ></v-img>

                            <v-card-title>{{ unidad.nombre }}</v-card-title>

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

                                <div class="grey--text ml-4">4.5 (413)</div>
                              </v-row>

                              <div>
                                {{ unidad.description }}
                              </div>
                            </v-card-text>

                            <v-divider class="mx-4"></v-divider>

                            <v-card-actions>
                              <v-btn color="deep-purple lighten-2" text>
                                Guardar
                              </v-btn>
                            </v-card-actions>
                          </v-card>
                          <v-card class="mx-auto my-12" max-width="374">
                            <v-img
                              height="250"
                              src="https://content.gnoss.ws/imagenesEnlaces/ab/ab79/ab79ad08-e602-42a9-8c88-56e154b78300/ab79ad08-e602-42a9-8c88-56e154b78300.jpg?1"
                            ></v-img>

                            <v-card-title>{{ unidad.nombre }}</v-card-title>

                            <v-card-text>
                              <v-row align="center" class="mx-0">
                                <v-rating
                                  :value="3"
                                  color="amber"
                                  dense
                                  half-increments
                                  readonly
                                  size="14"
                                ></v-rating>

                                <div class="grey--text ml-4">3 (1000000)</div>
                              </v-row>

                              <div>
                                {{ unidad.description }}
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
    async asyncData() {
      console.log('entre async')
      const url = '/unidades'
      const data = await axios.get(url)
      /* .then((response) => {
            console.log(response)
            //this.data = response
          })
          .catch((e) => {
            console.log(e)
          }) */
      return data
    },
    data() {
      return {
        grados: [
          {
            grado: '3',
            cursos: [
              {
                nombre: 'matematicas',
                unidades: [
                  {
                    nombre: 'funciones 1',
                    description: 'description',
                    videos: []
                  },
                  {
                    nombre: 'funciones 2',
                    description: 'description',
                    videos: []
                  },
                  {
                    nombre: 'funciones 3',
                    description: 'description',
                    videos: []
                  }
                ]
              },
              {
                nombre: 'quimica',
                unidades: [
                  {
                    nombre: 'moleculas 1',
                    description: 'description',
                    videos: []
                  },
                  {
                    nombre: 'moleculas 2',
                    description: 'description',
                    videos: []
                  },
                  {
                    nombre: 'moleculas 3',
                    description: 'description',
                    videos: []
                  }
                ]
              }
            ]
          },
          {
            grado: '4',
            cursos: [
              {
                nombre: 'matematicas',
                unidades: [
                  {
                    nombre: 'funciones 1',
                    description: 'description',
                    videos: []
                  },
                  {
                    nombre: 'funciones 2',
                    description: 'description',
                    videos: []
                  },
                  {
                    nombre: 'funciones 3',
                    description: 'description',
                    videos: []
                  }
                ]
              },
              {
                nombre: 'quimica',
                unidades: [
                  {
                    nombre: 'moleculas 1',
                    description: 'description',
                    videos: []
                  },
                  {
                    nombre: 'moleculas 2',
                    description: 'description',
                    videos: []
                  },
                  {
                    nombre: 'moleculas 3',
                    description: 'description',
                    videos: []
                  }
                ]
              }
            ]
          },
          {
            grado: '5',
            cursos: [
              {
                nombre: 'matematicas',
                unidades: [
                  {
                    nombre: 'funciones 1',
                    description: 'description',
                    videos: []
                  },
                  {
                    nombre: 'funciones 2',
                    description: 'description',
                    videos: []
                  },
                  {
                    nombre: 'funciones 3',
                    description: 'description',
                    videos: []
                  }
                ]
              },
              {
                nombre: 'quimica',
                unidades: [
                  {
                    nombre: 'moleculas 1',
                    description: 'description',
                    videos: []
                  },
                  {
                    nombre: 'moleculas 2',
                    description: 'description',
                    videos: []
                  },
                  {
                    nombre: 'moleculas 3',
                    description: 'description',
                    videos: []
                  }
                ]
              }
            ]
          }
        ]
      }
    },
    methods: {
      async onSubmit() {
        const url = '/unidades'
        await this.$axios
          .$get(url)
          .then((response) => {
            console.log(response)
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
