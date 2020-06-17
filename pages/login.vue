<template>
  <v-container>
    <v-row align="start" justify="center" class="mt-5">
      <v-col class="text-center my-style">
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
          <v-btn color="primary" class="mt-3" @click="onSubmit">Ingresar</v-btn>
        </v-form>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  export default {
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
        const url = ''
        await this.$auth
          .loginWith('local', { data: this.form })
          .then((res) => {})
          .catch((e) => {})
        await this.$axios
          .$post(url, {
            email: this.form.email,
            password: this.form.password
          })
          .then((res) => {})
          .catch((e) => {})
      }
    }
  }
</script>

<style>
  .my-style {
    max-width: 420px;
  }
</style>
