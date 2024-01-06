<script lang="ts">
	import { onMount } from 'svelte';

	type Line = {
		x: number;
		y: number;
		angle: number;
	};

	type Point = {
		x: number;
		y: number;
	};

    type Eye = {
        pos: Point;
        scale: number;
        radius: number;
        cycle: number;
        speed: number;
        times: number;
        winks: number;
        stare: number;
        stareCount: number
    }

    let eyes = [] as Eye[];
    
    const collides = (a: Eye, b: Eye) => {
        let dx = a.pos.x - b.pos.x;
        let dy = a.pos.y - b.pos.y;
        let distance = Math.sqrt(dx * dx + dy * dy);

        return distance < a.scale*100 + b.scale*100;
    }

    const advanceEye = (eye: Eye) => {
        eye.cycle += eye.times % 2 == 0 ? eye.speed : -eye.speed;
        eye.cycle = Math.max(0, Math.min(1, eye.cycle));

        if (eye.cycle == 0 && eye.stareCount < eye.stare) {
            eye.stareCount += eye.speed;
            return
        }

        if (eye.cycle == 0 || eye.cycle == 1) {
            eye.times++;
        }
    }

    const shouldDeleteEye = (eye: Eye) => {
        return eye.times > eye.winks;
    }

    const generateRandomEye = () => {
        let x = Math.random() * innerWidth;
        let y = Math.random() * innerHeight;

        let scale = Math.random() * 0.7 + 0.3;
        let radius = Math.random() * 10 + 20;
        let speed = Math.random() * 0.1 + 0.05;

        return { pos: { x, y }, scale, radius, cycle: 1.0, speed, times: 0, winks: Math.random() > 0.5 ? 2 : 4, stare: Math.random()*10, stareCount: 0 };
    }

    const generateWhileNotCollides = () => {
        let eye = generateRandomEye();

        while (eyes.some((e) => collides(e, eye))) {
            eye = generateRandomEye();
        }

        eyes.push(eye);
    }

    const removeEyes = () => {
        eyes = eyes.filter((e) => !shouldDeleteEye(e));
    }

	let canvas: HTMLCanvasElement;
	let context: CanvasRenderingContext2D | null;

	let innerWidth: number = 0;
	let innerHeight: number = 0;
	let interval: number = 57;
	let displacementX: number = 1;
	let displacementY: number = 1;
	let mouseDisplacementX: number = 10;
	let angleTilt = 1.0;

	let angle = (Math.PI / 180) * 30;

	let setup: boolean = false;
	let initialX: number = 0;
	let initialY: number = 0;

	let mouseX: number = 0;
	let mouseY: number = 0;

	let cameraX: number = 0;
	let cameraY: number = 0;

	let intersectY = (a: Line, x: number) => Math.tan(a.angle) * (x - a.x) + a.y;
	let intersectX = (a: Line, y: number) => (y - a.y) / Math.tan(a.angle) + a.x;

	const lerp = (x: number, y: number, a: number) => x * (1 - a) + y * a;

	const quadraticInterpolation = (x: number, y: number, t: number) =>
		x + (y - x) * (0.5 - 0.5 * Math.cos(t * Math.PI));

	const handleMove = (event: MouseEvent) => {
		if (!setup) {
			initialX = event.clientX;
			initialY = event.clientY;
			setup = true;
		}

		mouseX = event.clientX;
		mouseY = event.clientY;
	};

	const drawLadder = (point: Point, scale: number, step: number) => {
		if (context) {
            let x = point.x;
            let y = point.y;

			let endX = x + scale * 100;
			let diffX = scale * 30;

			let eyeOpening = 35*scale;


            context.save();
            
			context.moveTo(x, y);

			context.bezierCurveTo(
				x + diffX,
				quadraticInterpolation(y - eyeOpening, y + eyeOpening, step),
				endX - diffX,
				quadraticInterpolation(y - eyeOpening, y + eyeOpening, step),
				endX,
				y
			);

			context.bezierCurveTo(endX - diffX, y + eyeOpening, x + diffX, y + eyeOpening, x, y);


            context.restore()
		}
	};

	const drawEye = (point: Point, scale: number, radius: number, cycle: number) => {
		if (context) {
			context.strokeStyle = `rgba(0, 0, 0, 1.0)`;
			context.lineWidth = 3;

            // convert radial-gradient(circle, rgba(2,0,36,1) 0%, rgba(227,227,227,1) 0%, rgba(255,255,255,1) 100%)

            let gradient = context.createRadialGradient(point.x + 50*scale, point.y, 0, point.x + 50*scale, point.y, radius*2*scale);
            gradient.addColorStop(0.9, 'gray');
            gradient.addColorStop(0.2, 'white');
            gradient.addColorStop(0, 'rgba(255,255,255,1)');

            context.save();
            context.rotate(Math.PI/180 * (scale*50 - 25));
            context.translate(cameraX/10, cameraY/10);

			context.beginPath();
			drawLadder(point, scale, cycle);
			context.fillStyle = gradient;
			context.fill();
            context.stroke();
			context.closePath();

			context.clip();
            
            let posX = mouseX - point.x;
            let posY = mouseY - point.y;
            
			context.beginPath();
			context.arc(point.x + 50*scale + posX/30, point.y+ posY/50, radius*scale, 0, 2 * Math.PI, false);
			context.fillStyle = 'black';
			context.closePath();

			context.fill();

            context.beginPath();
			context.arc(point.x + 10 + 50*scale + posX/30, point.y - 10 + posY/50, radius/5*scale, 0, 2 * Math.PI, false);
			context.fillStyle = 'white';
			context.closePath();

			context.fill();

			context.restore();
		}
	};

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
	};

	onMount(() => {
		context = canvas.getContext('2d');

		const update = () => {
			cameraX = lerp(cameraX, mouseX - initialX, 0.05);
			cameraY = lerp(cameraY, mouseY - initialY, 0.05);

			let smallAngleTilt = cameraX / innerWidth / 10;

			angle =
				((Math.sin(performance.now() / 1000) * Math.PI) / 180) * angleTilt + 30 + smallAngleTilt;

			interval = Math.sin(performance.now() / 1000) * 0.1 + 70;

			context?.clearRect(0, 0, innerWidth, innerHeight);

			let widthIntervals = innerWidth / interval;
			let heightInterval = innerHeight / interval;

			for (let i = -heightInterval; i < heightInterval; i++) {
				let x =
					i * interval * Math.cos(angle) +
					innerWidth / 2 +
					cameraX / mouseDisplacementX +
					displacementX;
				let y =
					i * interval * Math.sin(angle) +
					innerHeight / 2 +
					cameraY / mouseDisplacementX +
					displacementY;
				drawLine({ x, y, angle: angle + Math.PI / 2 });
			}

			for (let i = -widthIntervals; i < widthIntervals * 2; i++) {
				let nAngle = angle + Math.PI / 2;
				let x =
					i * interval * Math.cos(nAngle) +
					innerWidth / 2 +
					cameraX / mouseDisplacementX +
					displacementX;
				let y =
					i * interval * Math.sin(nAngle) +
					innerHeight / 2 +
					cameraY / mouseDisplacementX +
					displacementY;
				drawLine({ x, y, angle: nAngle + Math.PI / 2 });
			}


            for (let i = 0; i < eyes.length; i++) {
                let eye = eyes[i];
                advanceEye(eye);
                drawEye(eye.pos, eye.scale, eye.radius, eye.cycle);
            }

            if (Math.random() < 0.05 && eyes.length < 15) {
                generateWhileNotCollides();
            }

            removeEyes();

			requestAnimationFrame(update);
		};

		requestAnimationFrame(update);
	});
</script>

<svelte:window bind:innerWidth bind:innerHeight on:mousemove={handleMove} />

<canvas bind:this={canvas} width={innerWidth} height={innerHeight}></canvas>

<style>
	canvas {
		position: fixed;
		top: 0;
		left: 0;
		z-index: -1;
	}
</style>
