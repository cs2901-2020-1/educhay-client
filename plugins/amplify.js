import Vue from 'vue'
import Amplify, * as AmplifyModules from 'aws-amplify'
import AmplifyPlugin from 'aws-amplify-vue/src/plugins/AmplifyPlugin'
import awsmobile from '~/aws-exports'
Amplify.configure(awsmobile)

Vue.use(AmplifyPlugin, AmplifyModules)
