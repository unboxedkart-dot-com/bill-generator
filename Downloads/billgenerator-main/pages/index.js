import Head from 'next/head'
import styles from '../styles/Home.module.css'

export default function Home() {
	return (
		<div className={styles.container}>
			<Head>
				<title>Bill Generator</title>
				<meta property="og:title" content="Bill Generator" key="title"/>
				<meta property="og:description" content="Bill Generator" key="description"/>
			</Head>
		</div>
	)
}
