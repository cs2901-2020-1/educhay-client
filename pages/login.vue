<template>
  <b-container class="p-0">
    <b-row align-v="center" align-h="center">
      <b-col md="4" class="p-5">
        <b-row align-h="center">
          <div class="bebas t-black t-7 text-uppercase">
            iniciar sesión
          </div>
        </b-row>
        <br />
        <b-form>
          <b-form-group
            id="email-group"
            label="Correo Electrónico:"
            label-for="email"
          >
            <b-form-input
              id="email"
              v-model="form.email"
              type="email"
              required
              placeholder="Ingrese correo electrónico"
            ></b-form-input>
          </b-form-group>
          <br />
          <b-form-group
            id="password-group"
            label="Contraseña"
            label-for="password"
          >
            <b-form-input
              id="password"
              v-model="form.password"
              type="password"
              required
              placeholder="Ingrese contraseña"
            ></b-form-input>
          </b-form-group>
          <br />
          <br />
          <b-row align-h="center" align-v="center" class="mt-10">
            <b-button variant="blue" @click="onSubmit">Ingresar</b-button>
          </b-row>
        </b-form>
      </b-col>
      <b-col md="8" class="text-center">
        <b-img class="index1" src="~/assets/img/8.jpg" alt="" fluid></b-img>
      </b-col>
    </b-row>
  </b-container>
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
