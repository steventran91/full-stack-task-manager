import { useEffect, useState } from "react";
import { useAuth } from "../context/AuthContext";
import client from "../api/client";
import type { Task } from "../types";

export default function Tasks() {
    const {logout} = useAuth();
    const [tasks, setTasks] = useState<Task[]>([]);
    const [title, setTitle] = useState('');
    const [description, setDescription] = useState('')
    const [error, setError] = useState<string | null>(null);

    useEffect(() => {
        client.get<Task[]>('/tasks')
        .then(res => setTasks(res.data))
        .catch(() => setError('Failed to load tasks'));
    }, []);

    async function handleCreate(e: React.SubmitEvent) {
        e.preventDefault()
        try {
            const res = await client.post<Task>('/tasks', {task: {title, description, status: 'pending'}});
            setTasks([...tasks, res.data]);
            setTitle('');
            setDescription('');
        } catch {
            setError('Failed to create task');
        };
    };

    async function handleDelete(id: number) {
        try {
            await client.delete(`/tasks/${id}`);
            setTasks(tasks.filter(task => task.id !== id));
        } catch {
            setError('Failed to delete task');
        };
    };

    async function handleStatusUpdate(task: Task) {
        const nextStatus: Record<string, string> = {
            pending: 'in_progress',
            in_progress: 'completed',
            completed: 'pending',
        };
        try {
            const res = await client.patch<Task>(`/tasks/${task.id}`, {task: {status: nextStatus[task.status]}});
            setTasks(tasks.map(t => t.id === task.id ? res.data : t));
        } catch {
            setError('Failed to update task');
        };
    };

    return (
        <div>
            <button onClick={logout}>Logout</button>
            <h1>My Tasks</h1>
            {error && <p style={{color: 'red'}}>{error}</p>}
            <form onSubmit={handleCreate}>
                <input
                    placeholder="New Task title"
                    value={title}
                    onChange={e => setTitle(e.target.value)}
                />
                <input
                    placeholder="Add Description..."
                    value={description}
                    onChange={e => setDescription(e.target.value)}
                />
                <button type="submit">Add Task</button>
            </form>
            <ul>
                {tasks.map(task => (
                    <li key={task.id}>
                        <span>{task.title} - {task.status}</span>
                        <button onClick={() => handleStatusUpdate(task)}>Next Status</button>
                        <button onClick={() => handleDelete(task.id)}>Delete</button>
                    </li>
                ))}
            </ul>
        </div>
    )
};