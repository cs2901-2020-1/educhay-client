<template>
  <b-container class="p-0">
    <br />
    <b-row align-h="center">
      <b-col md="8" class="pt-5">
        <b-img
          class="index1"
          src="~/assets/img/register.jpeg"
          alt=""
          fluid
        ></b-img>
      </b-col>
      <b-col md="4">
        <b-row align-h="center">
          <div class="bebas t-black t-7 text-uppercase">
            registro
          </div>
        </b-row>
        <b-row>
          <b-col>
            <b-row align-h="center">
              <v-btn
                :color="isProfe ? 'gray' : '#8dc740'"
                @click="isProfe = false"
                >Alumno</v-btn
              >
            </b-row>
          </b-col>
          <b-col>
            <b-row align-h="center">
              <v-btn
                :color="isProfe ? '#8dc740' : 'gray'"
                @click="isProfe = true"
                >Profesor</v-btn
              >
            </b-row>
          </b-col>
        </b-row>
        <br />
        <b-form>
          <b-form-group label="Nombres:" label-for="nombre">
            <b-form-input
              id="nombre"
              v-model="form.nombre"
              type="text"
              required
              placeholder="Ingresa tu nombre"
            ></b-form-input>
          </b-form-group>
          <br />
          <b-form-group label="Apellidos:" label-for="apellido">
            <b-form-input
              id="apellido"
              v-model="form.apellido"
              type="text"
              required
              placeholder="Ingresa tu apellido"
            ></b-form-input>
          </b-form-group>
          <br />
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
              placeholder="Ingresa tu correo electrónico"
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
          <b-row align-h="center" align-v="center" class="mt-10">
            <b-button variant="blue" @click="onSubmit">Registrarse</b-button>
          </b-row>
        </b-form>
      </b-col>
    </b-row>
  </b-container>
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
          errors.push('La contraseña debe tener al menos 8 caracteres.')
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
            this.$router.push('/login')
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
        // this.$auth.setUserToken().then(() => {})
      }
    }
  }
</script>
