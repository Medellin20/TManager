import { ref, computed } from 'vue'
import { defineStore } from 'pinia'

export const useApiRouteStore = defineStore('apiroute', () => {
  const baseUrl = ref('http://localhost:4000/api')
  return { baseUrl }
})
