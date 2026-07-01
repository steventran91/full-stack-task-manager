import { useAuth } from "./context/AuthContext";
import Login from "./pages/Login";
import Tasks from "./pages/Tasks";

export default function App() {
  const {token} = useAuth();

  if (!token) {
    return <Login/>;
  };

  return (
    <div>
      <Tasks/>
    </div>
  )
};