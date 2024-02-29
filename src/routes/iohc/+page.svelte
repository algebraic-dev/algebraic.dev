<svelte:head>
	<title>IOHC Meetup</title>

	<meta property="og:title" content="IOHC Meetup" />
	<meta property="og:type" content="website" />
	<meta property="og:url" content="https://www.algebraic.dev/iohc" />
	<meta property="og:image" content="https://www.algebraic.dev/iohc.png" />

	<meta
		property="og:description"
		content="Evento mensal de tech talks sobre system programming :D"
	/>

	<meta name="twitter:site" content="IOHC Meetup" />
	<meta name="twitter:title" content="IOHC Meetup" />
	<meta
		name="twitter:description"
		content="Evento mensal de tech talks sobre system programming :D"
	/>
	<meta name="twitter:card" content="summary_large_image" />
	<meta name="twitter:image:src" content="https://www.algebraic.dev/iohc.png" />

	<meta name="theme-color" content="#FFFFFF" />
</svelte:head>

<main class="container">
	<article>
		<div class="title">
			<h1 class="first">IO</h1>
			<h1 class="sec">HC</h1>
		</div>
		<h2>O que é?</h2>
		<p>
			Nosso objetivo é mergulhar em temas técnicos de maneira profunda e divertida, sem restrições
			específicas de tópicos. Alguns exemplos incluem Compiladores, Virtual Machines, Browsers,
			Kernel, Databases, Distributed Systems, PL Design, NFT, Blockchain, entre outros.
		</p>
		<h2>Quando?</h2>
		<p>
			A data do evento está a ser determinada (TBD). Estamos planejando realizar o evento com
			frequência mensal ou similar, proporcionando uma experiência contínua de aprendizado e
			networking.
		</p>
		<h2>Talks</h2>
		<p>
			Nossas talks abrangem uma variedade de formatos, incluindo leitura de papers, discussão sobre
			projetos pessoais, sessões de live coding, exposição de tópicos de interesse e
			compartilhamento de experiências de aprendizado.
		</p>
		<p>
			Para submeter uma proposta de talk acesse esse
			<a href="https://forms.gle/XZAbYyx5yeHZMeUW8">formulário</a>
		</p>
		<p>
			Você precisa apenas de um conhecimento básico em programação para acompanhar nossas palestras.
			Nosso objetivo é criar um ambiente onde qualquer pessoa que saiba codificar possa participar,
			aprender e se conectar com outros entusiastas. Para iniciantes, é uma excelente oportunidade
			para compreender como as coisas funcionam e construir uma rede com profissionais mais
			experientes.
		</p>
		<h2>Local</h2>
		<p>
			O evento será presencial e provavelmente nessas primeiras vezes em Belo Horizonte. Ainda estamos
			procurando um local!
		</p>
		<h2>Contato</h2>
		<p>
			Se desejar discutir qualquer tópico relacionado a talks, compartilhar ideias ou simplesmente
			fazer amizade com os organizadores do evento, sinta-se à vontade para entrar em contato pelos
			meios listados abaixo:
		</p>
		<a class="telegram" href="https://t.me/+9CkDkq-uVXk3YmJh">
			Telegram
		</a>
		<a class="whatsapp" href="https://chat.whatsapp.com/Hl6LM68lozI7tPkFp1VOtd">
			Whatsapp
		</a>
	</article>
</main>

<style>
	main {
		background: #fff;
		font-family: Poppins;
	}

	.container {
		display: flex;
		justify-content: center;
		align-items: center;
		min-height: 100vh;
		color: #070707;
	}

	h1 {
		font-size: 2em;
		text-align: center;
	}

	article {
		margin-top: 10%;
		width: 50%;
		margin-bottom: 10%;
	}

	.telegram {
		background-color: #0088cc;
		color: white;
		padding: 5px 10px;
		border-radius: 5px;
		text-decoration: none;
	}

	.whatsapp {
		background-color: #4be343;
		color: white;
		margin-left: 10px;
		padding: 5px 10px;
		border-radius: 5px;
		text-decoration: none;
	}

	@media screen and (max-width: 992px) {
		article {
			width: 80%;
		}
	}

	.title {
		display: flex;
		align-items: center;
	}

	.first {
		margin-right: 2px;
		font-weight: bold;
	}

	.sec {
		font-weight: 600;
	}

	table {
		border-collapse: collapse;
		border: 1px solid rgb(0, 0, 0);
		font-family: sans-serif;
		font-size: 0.8rem;
		letter-spacing: 1px;
	}

	thead {
		background-color: rgb(255, 255, 255);
	}

	th,
	td {
		border: 1px solid rgb(0, 0, 0);
		padding: 8px 10px;
	}

</style>
