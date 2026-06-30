export interface User {
    id: number;
    first_name: string;
    last_name: string;
    email: string;
};

export interface Task {
    id: number;
    title: string;
    description: string;
    status: string;
    due_date: string | null;
};

export interface AuthResponse {
    token: string;
    user: User;
};