<template>
  <div>
    <div class="px-4 py-2 text-white shadow-xl bg-slate-500">
      <div class="mb-2">
        <h1 class="text-4xl">{{data.title}}</h1>
      </div>
      <div class="my-2 mb-4">
        <h2>{{data.subtitle}}</h2>
      </div>
      <div class="my-2 mb-4">
        <ClientOnly>
          <SystemStats/>
        </ClientOnly>
      </div>
      <div class="mb-4">
        <input @keydown="goToOnly" v-model="query" type="text" class="w-full h-8 py-2 px-4  bg-slate-700" placeholder="Search">
      </div>
    </div>

    <div>
<!--      <ListView :data="data"/>-->
      <ClientOnly>
        <ColView :data="data"/>
      </ClientOnly>
    </div>
  </div>
</template>
<script setup>
import ListView from "~/components/ListView.vue";

const query = ref();
const props = defineProps({
  data: Object
})

const data = computed(() => {
  if (query.value) {
    return {
      ...props.data,
      items: props.data.items.filter(item => item.name.toLowerCase().includes(query.value.toLowerCase()))
    }
  }
  return props.data;
})

function goToOnly(event) {
  if (event.key === 'Enter') {
    const items = unref(data).items;
    if (query.value && items.length === 1) {
      window.open(items[0].url, items[0].target);
    }
  }
}
</script>