<script lang="ts">
	import { onMount } from 'svelte';

	let canvas: HTMLCanvasElement;
	let context: CanvasRenderingContext2D | null;

	let innerWidth: number = 0;
	let innerHeight: number = 0;

	onMount(() => {
		context = canvas.getContext('2d');
	});
</script>

<svelte:window bind:innerWidth bind:innerHeight />

<canvas bind:this={canvas} width={innerWidth} height={innerHeight}></canvas>

<style>
	/* styles go here */
</style>
