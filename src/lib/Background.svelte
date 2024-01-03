<script lang="ts">
	import { onMount } from 'svelte';

    type Line = {
        x: number,
        y: number,
        angle: number
    }

	let canvas: HTMLCanvasElement;
	let context: CanvasRenderingContext2D | null;

	let innerWidth: number = 0;
	let innerHeight: number = 0;
    let interval: number = 57;
    let displacementX: number = 1;
    let displacementY: number = 1;
    let mouseDisplacementX: number = 10;
    let angleTilt = 0.1;

    let angle = Math.PI/180 * 30;
    
    let setup: boolean = false;
    let initialX = 0;
    let initialY = 0;

    let mouseX = 0;
    let mouseY = 0;

    let cameraX = 0;
    let cameraY = 0;

    let intersectY = (a: Line, x: number) => Math.tan(a.angle) * (x - a.x) + a.y;
    let intersectX = (a: Line, y: number) => (y - a.y) / Math.tan(a.angle) + a.x;

    const lerp = (x: number, y: number, a: number) => x * (1 - a) + y * a;

    const handleMove = (event: MouseEvent) => {

        if (!setup) {
            initialX = event.clientX;
            initialY = event.clientY;
            setup = true;
        }

        mouseX = event.clientX;
        mouseY = event.clientY;
    }

    const drawLine = (line: Line) => {
        if (context) {
            
            let intersectionTop = intersectY(line, 0);
            let intersectionDown = intersectY(line, innerWidth);

            let intersectLeft = intersectX(line, 0);
            let intersectRight = intersectX(line, innerHeight);

            context.beginPath();
                context.strokeStyle = `rgba(157, 157, 157, 0.2)`;
                context.lineWidth = 1;
                
                if (intersectionTop < 0) {
                    context.moveTo(intersectLeft, 0);
                } else {
                    context.moveTo(0, intersectionTop);
                }

                if (intersectionDown > innerHeight) {
                    context.lineTo(intersectRight, innerHeight);
                } else {
                    context.lineTo(innerWidth, intersectionDown);
                }
        
                context.stroke();

        }
    }

	onMount(() => {
		context = canvas.getContext('2d');

        const update = () => {
            cameraX = lerp(cameraX, mouseX - initialX, 0.05);
            cameraY = lerp(cameraY, mouseY - initialY, 0.05);

            angle = Math.sin(performance.now() / 1000) * Math.PI/180 * angleTilt + 30;

            interval = Math.sin(performance.now() / 1000) * 0.1 + 70;


            context?.clearRect(0, 0, innerWidth, innerHeight);

            let widthIntervals = innerWidth / interval;
            let heightInterval = innerHeight / interval;

            for (let i = -widthIntervals; i < widthIntervals*2; i++) {
                let x = (i * interval)*Math.cos(angle) + innerWidth/2 + cameraX/mouseDisplacementX + displacementX;
                let y = (i * interval)*Math.sin(angle) + innerHeight/2 + cameraY/mouseDisplacementX + displacementY;
                drawLine({x, y, angle: angle + Math.PI/2 })
            }
            
            for (let i = -heightInterval; i < heightInterval*2; i++) {
                let nAngle = angle + Math.PI/2;
                let x = (i * interval)*Math.cos(nAngle) + innerWidth/2 + cameraX/mouseDisplacementX + displacementX;
                let y = (i * interval)*Math.sin(nAngle) + innerHeight/2 + cameraY/mouseDisplacementX + displacementY;
                drawLine({x, y, angle: nAngle + Math.PI/2 })
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
