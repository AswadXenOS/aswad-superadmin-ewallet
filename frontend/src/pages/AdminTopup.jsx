import { useEffect, useState } from "react";
import axios from "axios";

function AdminTopup() {
  const [topups, setTopups] = useState([]);

  const fetchTopups = async () => {
    const res = await axios.get("/topup/list");
    setTopups(res.data);
  };

  const approve = async (id) => {
    await axios.post("/topup/approve/" + id);
    fetchTopups();
  };

  useEffect(() => { fetchTopups(); }, []);

  return (
    <div className="p-4">
      <h2 className="text-xl font-bold mb-2">Panel Admin: Topup</h2>
      {topups.map((t) => (
        <div key={t.id} className="border p-2 my-2 rounded">
          <div>👤 {t.name} — {t.email}</div>
          <div>💰 RM{t.amount}</div>
          <div>Status: <b>{t.status}</b></div>
          {t.status === "pending" && (
            <button onClick={() => approve(t.id)} className="bg-green-600 text-white px-2 mt-1 rounded">
              Approve ✅
            </button>
          )}
        </div>
      ))}
    </div>
  );
}

export default AdminTopup;
