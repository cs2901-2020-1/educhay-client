<template>
  <v-container fluid class="p-0">
    <v-row align="start">
      <v-col md="8" class="hidden-sm-and-down p-0" align="flex-start">
        <b-img src="~/assets/login1.png" fluid-grow class="p-0"></b-img>
        <!--<v-img src="~/assets/login1.png" aspect-ratio="1"></v-img> -->
      </v-col>
      <v-col sm="12" md="4" align="center" justify="center">
        <div class="text-center my-style justify-content-center">
          <h1 class="m-5">Iniciar sesión</h1>
          <v-form>
            <v-text-field
              v-model="form.email"
              type="email"
              label="Correo electronico"
              outlined
            />
            <v-text-field
              v-model="form.password"
              type="password"
              label="Contraseña"
              outlined
            />
            <v-btn color="primary" class="mt-3" @click="onSubmit"
              >Ingresar</v-btn
            >
          </v-form>
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  export default {
    auth: false,
    data() {
      return {
        form: {
          email: '',
          password: ''
        }
      }
    },
    methods: {
      async onSubmit() {
        // const url = this.$store.state.base_url + 'login_temp'
        await this.$auth
          .loginWith('local', { data: this.form })
          .then((res) => {
            console.log(res)
            this.$auth.setUser(res.data)
            this.$router.push('/')
          })
          .catch((e) => {
            console.log(e)
          })
        // await this.$axios
        //   .$post(url, {
        //     email: this.form.email,
        //     password: this.form.password
        //   })
        //   .then((res) => {
        //     console.log(res)
        //   })
        //   .catch((e) => {
        //     console.log(e)
        //   })
      }
    }
  }
</script>

<style>
  .my-style {
    max-width: 420px;
    display: flex;
    flex-direction: column;
    height: 80vh;
  }
</style>
