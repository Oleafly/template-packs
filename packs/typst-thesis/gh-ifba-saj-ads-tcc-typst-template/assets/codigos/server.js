import express from 'express';
const app = express();
app.use(express.json());

app.get('/api/status', (req, res) => {
  res.json({ status: 'online', campus: 'IFBA-SAJ' });
});

app.post('/api/login', (req, res) => {
  const { user, password } = req.body;
  // Autenticação simulada
  res.json({ ok: user === 'admin' && password === 'admin' });
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));