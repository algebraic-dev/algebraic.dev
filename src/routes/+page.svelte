<script>
	import Background from "$lib/Background.svelte";
	import Box from "$lib/Box.svelte";
	import "$lib/global.css";
</script>

<Background/>

<div class="container">
	<Box />
</div>

<style>
	.container {
		display: flex;
		justify-content: center;
		align-items: center;
		text-align: center;
		min-height: 100vh;
	}
</style>
