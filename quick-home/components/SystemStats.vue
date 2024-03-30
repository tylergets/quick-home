<script setup lang="ts">
const { data, pending } = await useFetch('/api/system')
</script>

<template>
  <div v-if="pending">
    Loading...
  </div>
  <div v-else>
    <div class="flex gap-4 text-sm items-center">

      <div class="bg-slate-700 px-4 py-1 rounded-sm">
        <div class="flex gap-2">
          <div class="font-bold text-slate-400">HOST</div>
          <div>{{data.hostname}}</div>
        </div>
      </div>

      <div class="bg-slate-700 px-4 py-1 rounded-sm">
        <div class="flex gap-2">
          <div class="font-bold text-slate-400">CPU</div>
          <div>{{data.cpu.usage}}%</div>
        </div>
      </div>

      <div class="bg-slate-700 px-4 py-1 rounded-sm">
        <div class="flex gap-2">
          <div class="font-bold text-slate-400">MEM</div>
          <div>{{data.mem.info.usedMemPercentage}}%</div>
        </div>
      </div>

      <div class="bg-slate-700 px-4 py-1 rounded-sm">
        <div class="flex gap-2">
          <div class="font-bold text-slate-400">DISK</div>
          <div>{{data.drive.free.freeGb}}G</div>
        </div>
      </div>

      <div class="bg-slate-700 px-4 py-1 rounded-sm">
        <div class="flex gap-2">
          <div class="font-bold text-slate-400">OFD</div>
          <div>{{data.openfiles}}</div>
        </div>
      </div>

    </div>
  </div>
</template>
