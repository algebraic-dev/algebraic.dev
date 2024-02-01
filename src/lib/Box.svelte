<script lang="ts">
	import Button from "./Button.svelte";

    const handleMove = (ev: MouseEvent) => {
        let target = ev.currentTarget as HTMLElement;
        let rect = target.getBoundingClientRect();

        let x = ev.clientX - rect.left;
        let y = ev.clientY - rect.top;

        target.style.setProperty('--x', x + 'px');
        target.style.setProperty('--y', y + 'px');
    }
</script>

<main on:mousemove={handleMove}>
    <div class="container">
        <div class="title">
            「 algebraic
            <span style="color: #58FF73">sofia</span>
             」
        </div>
        <div class="desc">
            . . Hi, I’m Sofia a 21yo _ software developer _ _
        </div>
        <div class="buttons">
            <Button filled>ENTER</Button>
            <Button>ABOUT ME</Button>
        </div>
    </div>
</main>

<style>
    .title {
        font-family: Inconsolata; 
        font-size: 30px;
        color: white;
        margin: 20px;
    }

    .desc {
        font-family: Inconsolata;
        width: 80%;
        font-size: 15px;
        color: white;
        margin: 10%;
    }

    main {
		border: 1px solid rgba(157, 157, 157, 0.2);
		width: 500px;
		height: 400px;
		background-color: black;
        position: relative;
		border-radius: 2px;
        transition: transform 0.2s ease-in-out;

        display: flex;
		justify-content: center;
		align-items: center;
		text-align: center;
	}

    .buttons {
        gap: 10px;
        display: flex;
        width: 100%;
        justify-content: center;
        max-width: 100%;

    }

    main:hover {
        transform: scale(1.01)
    }


    @media only screen and (max-width: 600px) {
        main {
            width: calc(100% - 50px);
            height: 70vh;
        }
        
        .title {
            font-size: 20px;
        }

        .buttons {
            flex-direction: column;
            width: 90%;
            margin: auto;
        }
    }
</style>