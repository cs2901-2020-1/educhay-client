<template>
  <v-container>
    <div>
      <h1 class="mb-3">Register</h1>

      <!-- Unauthenticated -->
      <div v-if="!$auth.isAuthenticated">
        <!-- Register -->

        <form v-if="step === steps.register" @submit.prevent="register">
          <input
            v-model="registerForm.email"
            type="email"
            placeholder="Email"
            class="form-control"
          />
          <input
            v-model="registerForm.password"
            type="password"
            placeholder="Password"
            class="form-control"
          />
          <v-btn color="primary" class="mt-3" @click="onSubmit">Register</v-btn>
        </form>

        <!-- Confirm Registration -->
        <form v-else @submit.prevent="confirm">
          <input
            v-model="confirmForm.email"
            type="email"
            placeholder="Email"
            class="form-control"
          />
          <input
            v-model="confirmForm.code"
            placeholder="Code"
            class="form-control"
          />
          <v-btn color="primary" class="mt-3" @click="onSubmit">Confirm</v-btn>
        </form>

        <nuxt-link to="/login">Si ya tienes una cuenta inicia sesion</nuxt-link>
      </div>

      <!-- Authenticated -->
      <div v-else>
        You're logged in as {{ $auth.email }}.
        <button
          class="button--green"
          @click="$store.dispatch('amplifyauth/logout')"
        >
          Logout
        </button>
      </div>
    </div>
  </v-container>
</template>

<script>
const steps = {
  register: 'REGISTER',
  confirm: 'CONFIRM'
}
export default {
  data: () => ({
    steps: { ...steps },
    step: steps.register,
    registerForm: {
      email: '',
      password: ''
    },
    confirmForm: {
      email: '',
      code: ''
    }
  }),
  methods: {
    async register() {
      try {
        await this.$store.dispatch('amplifyauth/register', this.registerForm)
        this.confirmForm.email = this.registerForm.email
        this.step = this.steps.confirm
      } catch (error) {}
    },
    async confirm() {
      try {
        await this.$store.dispatch(
          'amplifyauth/confirmRegistration',
          this.confirmForm
        )
        await this.$store.dispatch('amplifyauth/login', this.registerForm)
        this.$router.push('/')
      } catch (error) {}
    }
  }
}
</script>
