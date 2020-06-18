<template>
  <v-container fluid class="p-0">
    <v-row align="start">
      <v-col sm="12" md="4" align="center" justify="center">
        <div class="text-center my-style justify-content-center">
          <h1 class="m-5">Registro</h1>
          <v-form>
            <v-text-field
              v-model="form.name"
              type="text"
              label="Nombres"
              outlined
            />
            <v-text-field
              v-model="form.lastName"
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
            <!-- <v-text-field
            v-model="form.schoolName"
            type="text"
            label="Colegio"
            outlined
          />
            <v-text-field
              v-model="form.username"
              type="text"
              label="Nombre de usuario"
              outlined
            />
            -->
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
        <b-img src="~/assets/class3.jpg" fluid-grow class="p-0"></b-img>
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
          // name: '',
          // lastName: '',
          // schoolName: '',
          // email: '',
          username: '',
          password: ''
        }
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
      onSubmit() {
        const url = '/register'
        // this.$v.$touch()
        this.$axios
          .$post(url, {
            nombre: this.form.name,
            apellido: this.form.lastName,
            // schoolName: this.form.schoolName,
            email: this.form.email,
            password: this.form.password
          })
          .then((res) => {
            console.log(res)
          })
          .catch((e) => {
            console.log(e)
          })
        // this.$auth.setUserToken().then(() => {})
      }
    }
  }
</script>

<style>
  .my-style {
    max-width: 420px;
  }
</style>
