import {useState} from 'react';
import { useAuth } from '../context/AuthContext';
import client from '../api/client';
import type { AuthResponse } from '../types';

export default function Login() {
    const {login} = useAuth();
    const [isRegistering, setIsRegistering] = useState(false);
    const [firstName, setFirstName] = useState('');
    const [lastName, setLastName] = useState('');
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [error, setError] = useState<string | null>(null);

    async function handleSubmit(e: React.SubmitEvent) {
        e.preventDefault();
        setError(null);

        try {
            const endpoint = isRegistering ? '/auth/register' : '/auth/login';
            const payload = isRegistering ? {first_name: firstName, last_name: lastName, email, password} : {email, password};

            const res = await client.post<AuthResponse>(endpoint, payload);
            login(res.data.token, res.data.user);
        } catch (err: any) {
            setError(err.response?.data?.error || 'Something went wrong');
        };
    };

    return (
        <div>
            <h1>{isRegistering ? 'Register' : 'Login'}</h1>
            {error && <p style={{color: 'red'}}>{error}</p>}
            <form onSubmit={handleSubmit}>
                {isRegistering && (
                    <>
                        <input placeholder="First name" value={firstName} onChange={e => setFirstName(e.target.value)}/>
                        <input placeholder="Last name" value={lastName} onChange={e => setLastName(e.target.value)}/>
                    </>
                )}
                <input placeholder="Email" value={email} onChange={e => setEmail(e.target.value)} />
                <input type="password" placeholder="Password" value={password} onChange={e => setPassword(e.target.value)}/>
                <button type="submit">{isRegistering ? 'Register' : 'Login'}</button>
            </form>
            <button onClick={() => setIsRegistering(!isRegistering)}>
                {isRegistering ? 'Already have an account? Login' : 'No Account? Register'}
            </button>
        </div>
    )

};