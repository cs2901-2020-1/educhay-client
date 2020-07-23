<template>
  <!-- <v-container fluid class="p-0">
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
  </v-container> -->
  <b-container class="p-0">
    <br />
    <b-row align-h="center" align-v="center">
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

<style>
  .alumnos {
    padding-left: 4rem;
  }
  .grade {
    position: absolute;
    right: 25%;
    bottom: 28%;
    transform-origin: center;
    transform: rotate(-90deg);
    max-width: 100%;
    height: 35%;
  }
  .curso {
    position: relative;
    margin-left: 7rem;
    width: 100%;
  }
  .curso-border:after {
    content: '';
    position: absolute;
    border: 0.5rem solid #0bbfe0;
    width: 70%;
    right: 0;
    bottom: 0;
  }
  .cursos {
    position: absolute;
    left: 0;
    bottom: 10%;
    /* transform-origin: center; */
    transform: rotate(-90deg);
    border-left: 15rem solid #fedd09;
    max-width: 100%;
    height: 35%;
  }
  .banner {
    background-color: #8dc740;
  }
  .bebas {
    font-family: 'Bebas Neue', cursive !important;
  }
  .quick {
    font-family: 'Quicksand', sans-serif !important;
  }
  .t-1 {
    font-size: 1rem;
  }
  .t-2 {
    font-size: 2rem;
  }
  .t-3 {
    font-size: 3rem;
  }
  .t-4 {
    font-size: 4rem;
  }
  .t-5 {
    font-size: 5rem;
  }
  .t-6 {
    font-size: 6rem;
  }
  .t-7 {
    font-size: 7rem;
  }
  .t-8 {
    font-size: 8rem;
  }
  .t-9 {
    font-size: 9rem;
  }
  .t-10 {
    font-size: 10rem;
  }
  .t-green {
    color: #8dc740;
  }
  .t-yellow {
    color: #fedd09;
  }
  .t-skyblue {
    color: #b0dee4;
  }
  .t-black {
    color: #010101;
  }
  .t-blue {
    color: #0bbfe0;
  }

  .logo {
    font-weight: 900;
    color: rgb(25, 84, 140);
  }

  .enter {
    padding: 1rem 0 0 0;
    width: auto;
    color: white !important;
  }

  #title {
    text-align: center;
    color: white;
    font-weight: bold !important;
    padding: 0 0 6rem 0;
    font-size: 1.5rem !important;
  }

  #title > h2 {
    font-weight: bolder;
  }

  .parallax {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    background-image: url(../assets/slide1.png);

    height: 70vh;

    background-attachment: fixed;
    background-position: top;
    background-repeat: no-repeat;
    background-size: cover;
  }
  .btn-blue {
    background-color: #0bbfe0;
    color: #fff;
    text-transform: uppercase;
    font-size: 1.2rem;
    border-radius: 10px;
    padding: 10px 30px;
    border: 4px solid #fff;
    /* box-shadow: inset 0 0 0 1px #b0dee4; */
  }

  .btn-blue:hover {
    /* box-shadow: inset 0 0 0 2px #b0dee4; */
    height: calc(96%);
    color: #fff;
    border: 4px solid #b0dee4;
  }
  .my-style {
    max-width: 420px;
  }

  .registerp {
    height: 94vh !important;
  }
</style>
