<template>
  <!-- <div>
    <div class="parallax">
      <div id="title" class="title">
        <p>La plataforma de cursos más completa del país</p>
        <h2>Aprende con Educhay</h2>
      </div>
      <template v-if="!$auth.loggedIn">
        <v-btn color="rgb(1, 166, 255)" class="enter" to="/register">
          ¡Registrate ya!
        </v-btn>
      </template>
    </div>
  </div> -->
  <b-container>
    <b-row class="mt-5 pt-3">
      <b-col md="6">
        <b-img class="index1" src="~/assets/img/1.jpg" alt="" fluid></b-img>
      </b-col>
      <b-col md="5">
        <b-row align-h="end">
          <div class="text-uppercase bebas t-green t-8">
            aprende
          </div>
        </b-row>
        <b-row align-h="end">
          <div class="text-uppercase bebas t-green t-8">
            con
          </div>
        </b-row>
        <b-row align-h="end">
          <div class="text-uppercase bebas t-blue t-8">
            educhay
          </div>
        </b-row>
        <b-row align-h="end">
          <b-col md="8">
            <div
              class="text-right text-white t-2 text-uppercase bebas banner p-3"
            >
              La plataforma de cursos de colegio más completa del país
            </div>
          </b-col>
        </b-row>
      </b-col>
      <b-col align-self="end">
        <b-img class="index1" src="~/assets/img/4.jpg" alt="" fluid></b-img>
      </b-col>
    </b-row>
    <br />
    <b-row class="mt-5" align-h="center">
      <b-col md="2">
        <div class="t-black pl-5 t-6 bebas text-uppercase cursos">
          cursos steam
        </div>
      </b-col>
      <b-col md="4" align-self="center">
        <b-row>
          <div class="bebas t-6 t-green curso mt-5 text-uppercase">
            aritmética
            <div class="curso-border"></div>
          </div>
        </b-row>
        <b-row>
          <div class="bebas t-6 t-green curso mt-5 text-uppercase">
            geometría
            <div class="curso-border"></div>
          </div>
        </b-row>
        <b-row>
          <div class="bebas t-6 t-green curso mt-5 text-uppercase">
            química
            <div class="curso-border"></div>
          </div>
        </b-row>
      </b-col>
      <b-col md="6">
        <b-img class="index1" src="~/assets/img/5.jpg" alt="" fluid></b-img>
      </b-col>
    </b-row>
    <b-row class="mt-5">
      <b-col md="7">
        <b-img class="index1" src="~/assets/img/7.jpg" alt="" fluid></b-img>
      </b-col>
      <b-col md="3" class="bebas alumnos" align-self="center">
        <b-row align-h="center">
          <div class="text-uppercase t-4 t-black">
            para alumnos de:
          </div>
        </b-row>
        <b-row>
          <b-col>
            <b-row align-h="end">
              <div class="t-green text-uppercase t-4">
                3ro
              </div>
            </b-row>
            <b-row align-h="end">
              <div class="t-green text-uppercase t-4">
                4to
              </div>
            </b-row>
            <b-row align-h="end">
              <div class="t-green text-uppercase t-4">
                5to
              </div>
            </b-row>
          </b-col>
          <b-col>
            <b-row>
              <div class="grade t-yellow t-4 text-uppercase">
                secundaria
              </div>
            </b-row>
          </b-col>
        </b-row>
      </b-col>
      <b-col md="2" align-self="end">
        <b-img
          class="index1"
          src="~/assets/img/square.jpeg"
          alt=""
          fluid
        ></b-img>
      </b-col>
    </b-row>
  </b-container>
</template>

<script>
  export default {
    auth: false
  }
</script>
