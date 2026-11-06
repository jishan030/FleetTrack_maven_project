const API_URL = 'http://localhost:8080';

export const checkBackendHealth = async () => {
    try {
        const response = await fetch(`${API_URL}/api/health`);

        if (!response.ok) {
            throw new Error(`HTTP Error: ${response.status}`);
        }

        return await response.text();

    } catch (error) {
        console.error('Backend Connection Error:', error);
        throw error;
    }
};