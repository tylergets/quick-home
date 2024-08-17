<script setup >
import ColEntry from "~/components/ColEntry.vue";

const props = defineProps({
  data: Object
})

const columnsWithItems = computed(() => {
  const columnCount = props.data.columns;
  const items = props.data.items;
  if(!items) return []
  // split items into columns evenly
  return items.reduce((acc, item, index) => {
    const columnIndex = index % columnCount;
    if (!acc[columnIndex]) {
      acc[columnIndex] = [];
    }
    acc[columnIndex].push(item);
    return acc;
  }, []);
})
</script>

<template>


  <div class="gap-4 flex">
    <div class="flex-1" v-for="column in columnsWithItems">
        <div class="px-4">
          <div v-for="item in column">
            <ColEntry :item="item"/>
          </div>
        </div>
    </div>
  </div>

</template>

<style scoped>

</style>