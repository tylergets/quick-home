<script setup >
const { data, error, pending } = await useFetch('/api/settings')

const hasError = computed(() => {
  if (error.value) {
    return error.value;
  }
  if (data.value.failed) {
    return data.value;
  }
})

useSeoMeta({
  title: computed(() => {
    if (data.value.title) {
      return data.value.title;
    }
    return 'Quick Home Dashboard';
  }),
  description: 'Quick Home Dashboard',
})

</script>

<template>
  <div v-if="pending">
    Loading...
  </div>
  <div v-else>
    <div v-if="hasError" class="h-screen">
      <div class="flex items-center flex-col h-full gap-4 justify-center">
        <div>
          Unable to load data. Please check your configuration.
        </div>
        <div>
          <div class="text-sm text-red-500">
            {{hasError}}
          </div>
        </div>
      </div>
    </div>
    <MainDash v-else :data="data" />
  </div>
</template>
