<template>
  <v-container fluid class="p-0">
    <v-row align="start">
      <v-col sm="12" md="4" align="center" justify="center">
        <div class="text-center my-style justify-content-center">
          <h1 class="m-5">Registro</h1>
          <v-form>
            <v-row class="mb-5">
              <v-col>
                <v-btn
                  :color="isProfe ? 'gray' : 'cyan'"
                  @click="isProfe = false"
                  >Alumno</v-btn
                >
              </v-col>
              <v-col>
                <v-btn
                  :color="isProfe ? 'cyan' : 'gray'"
                  @click="isProfe = true"
                  >Profesor</v-btn
                >
              </v-col>
            </v-row>
            <v-text-field
              v-model="form.nombre"
              type="text"
              label="Nombres"
              outlined
            />
            <v-text-field
              v-model="form.apellido"
              type="text"
              label="Apellidos"
              outlined
            />
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
              >Registrar</v-btn
            >
          </v-form>
        </div>
      </v-col>
      <v-col md="8" class="hidden-sm-and-down p-0" align="flex-end">
        <b-img
          src="~/assets/class3.jpg"
          fluid-grow
          class="p-0 registerp"
        ></b-img>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  import { validationMixin } from 'vuelidate'
  import { required, maxLength, email } from 'vuelidate/lib/validators'
  export default {
    auth: false,
    mixins: [validationMixin],
    validations: {
      form: {
        email: { required, email, maxLength: maxLength(10) },
        password: { required, maxLength: maxLength(8) }
      }
    },
    data() {
      return {
        form: {
          nombre: '',
          apellido: '',
          email: '',
          password: ''
        },
        isProfe: false
      }
    },
    computed: {
      emailErrors() {
        const errors = []
        if (!this.$v.form.email.$dirty) return errors
        !this.$v.form.email.email && errors.push('Must be valid e-mail')
        !this.$v.form.email.required && errors.push('E-mail is required')
        return errors
      },
      passwordErrors() {
        const errors = []
        if (!this.$v.form.password.$dirty) return errors
        !this.$v.form.password.maxLength &&
          errors.push('Password must be at least 8 characters long.')
        return errors
      }
    },
    methods: {
      async onSubmit() {
        const url = this.isProfe ? '/register/profe' : '/register'
        // this.$v.$touch()
        await this.$axios
          .$post(url, this.form)
          .then((res) => {
            console.log(res)
          })
          .catch((e) => {
            console.log(e)
          })
        /*
        this.$auth
          .loginWith('local', { data: this.form })
          .then((res) => {
            console.log(res)
            this.$auth.setUser(this.form)
            this.$router.push('/')
          })
          .catch((e) => {
            console.log(e)
          })
          */
        this.$router.push('/login')
        // this.$auth.setUserToken().then(() => {})
      }
    }
  }
</script>

<style>
  .my-style {
    max-width: 420px;
  }

  .registerp {
    height: 94vh !important;
  }
</style>
