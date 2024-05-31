import "./App.css";
import { useState, useEffect } from "react";

function App() {
	const [users, setUsers] = useState([]);

	useEffect(() => {
		fetch("https://test30.tttn.vn/users")
			.then((response) => response.json())
			.then((data) => setUsers(data))
			.catch((error) => console.error("Error fetching users:", error));
	}, []);

	return (
		<div className="App">
			<h1>Test Docker</h1>
			<h2>User List:</h2>
			<ul>
				{users.map((user) => (
					<li key={user.id}>{user.firstName}</li>
				))}
			</ul>
		</div>
	);
}

export default App;
