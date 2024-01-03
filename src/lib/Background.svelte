<script lang="ts">
	import { onMount } from 'svelte';

	let canvas: HTMLCanvasElement;
	let context: CanvasRenderingContext2D | null;

	let innerWidth: number = 0;
	let innerHeight: number = 0;
    let interval: number = 57;
    let displacementX: number = 20;
    let displacementY: number = 20;
    let mouseDisplacement: number = 10;

    let angle = 0;
    
    let mouseX = 0;
    let mouseY = 0;

    let cameraX = 0;
    let cameraY = 0;

    const lerp = (x: number, y: number, a: number) => x * (1 - a) + y * a;

    const handleMove = (event: MouseEvent) => {
        mouseX = event.clientX;
        mouseY = event.clientY;
    }

    const drawLine = (orientation: 'vertical' | 'horizontal', position: number) => {
        if (context) {
            
            context.beginPath();
            context.strokeStyle = 'rgba(157, 157, 157, 0.20)';
            context.lineWidth = 1;

            displacementX = Math.sin(Date.now() / 3000) * 20 + 10;
            displacementY = Math.sin(Date.now() / 5670) * 17 + 7;

            if (orientation === 'vertical') {
                context.moveTo(position, 0);
                context.lineTo(position, innerHeight);
            } else {
                context.moveTo(0, position);
                context.lineTo(innerWidth, position);
            }

            context.stroke();
        }
    }

	onMount(() => {
		context = canvas.getContext('2d');

        const update = () => {
            cameraX = lerp(cameraX, mouseX, 0.05);
            cameraY = lerp(cameraY, mouseY, 0.05);

            context?.clearRect(0, 0, innerWidth, innerHeight);

            for (let i = 0; i < innerWidth / interval; i++) {
                drawLine('vertical', i * interval - displacementX + cameraX/mouseDisplacement);
            }

            for (let i = 0; i < innerHeight / interval; i++) {
                drawLine('horizontal', i * interval - displacementY + cameraY/mouseDisplacement);
            }
            
            requestAnimationFrame(update);
        }

        requestAnimationFrame(update);
	});

</script>

<svelte:window bind:innerWidth bind:innerHeight />

<canvas bind:this={canvas} width={innerWidth} height={innerHeight} on:mousemove={handleMove}></canvas>

<style>
	/* styles go here */
</style>
