<script>
	export let filled = false;
	export let color = '255, 255, 255';

    let hovered = false;

	let backgroundColor = filled ? `rgb(${color})` : 'transparent';
	let border = filled ? 'none' : `1px solid rgb(${color})`;
	let textColor = filled ? 'black' : `rgb(${color})`;
</script>

<button
	style="background-color: {!hovered ? backgroundColor : `rgb(${color})`}; border: {border}; color: {hovered ? 'black' : textColor}; filter: drop-shadow(0px 0px 10px rgba({color}, 0.5))"
    on:mouseenter={() => hovered = true} on:mouseleave={() => hovered = false}
>
	<slot />
</button>

<style lang="scss">
	button {
		padding: 17px 50px;
		border: none;
		font-family: Inconsolata;
		font-size: 17px;
		min-width: 180px;
        transition: background 0.5s ease-in-out;
		cursor: pointer;
	}
</style>
