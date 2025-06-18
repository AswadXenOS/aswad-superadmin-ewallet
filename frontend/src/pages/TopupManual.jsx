import { useState } from "react";
import axios from "axios";

function TopupManual() {
  const [form, setForm] = useState({ name: "", email: "", amount: "" });
  const [success, setSuccess] = useState(false);

  const handleChange = (e) => setForm({ ...form, [e.target.name]: e.target.value });

  const submit = async (e) => {
    e.preventDefault();
    const res = await axios.post("/topup/request", form);
    setSuccess(res.data.success);
  };

  return (
    <div className="p-4">
      <h2 className="text-xl font-bold mb-2">Topup Manual</h2>
      <form onSubmit={submit} className="space-y-2">
        <input className="border p-1 w-full" name="name" placeholder="Nama" onChange={handleChange} />
        <input className="border p-1 w-full" name="email" placeholder="Email" onChange={handleChange} />
        <input className="border p-1 w-full" name="amount" placeholder="Amaun (RM)" onChange={handleChange} />
        <button className="bg-blue-500 text-white px-4 py-1 rounded">Hantar</button>
      </form>
      {success && <p className="text-green-600 mt-2">✅ Permintaan dihantar!</p>}
    </div>
  );
}

export default TopupManual;
