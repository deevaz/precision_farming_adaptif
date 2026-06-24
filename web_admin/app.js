import { initializeApp } from "https://www.gstatic.com/firebasejs/10.12.2/firebase-app.js";

import {
  getFirestore,
  collection,
  doc,
  setDoc,
  deleteDoc,
  onSnapshot,
} from "https://www.gstatic.com/firebasejs/10.12.2/firebase-firestore.js";

import {
  getAuth,
  signInWithEmailAndPassword,
  onAuthStateChanged,
  signOut,
} from "https://www.gstatic.com/firebasejs/10.12.2/firebase-auth.js";

const firebaseConfig = {
  apiKey: "AIzaSyC7P6wDegmuy2b3tlHu-amyY2U1lzjcnOw",
  authDomain: "precision-farming-682c2.firebaseapp.com",
  projectId: "precision-farming-682c2",
  storageBucket: "precision-farming-682c2.firebasestorage.app",
  messagingSenderId: "711528601248",
  appId: "1:711528601248:web:3cdac275fc3f1ef2345bc5",
  measurementId: "G-Q64QJZS1R2",
};

const app = initializeApp(firebaseConfig);
const db = getFirestore(app);
const auth = getAuth(app);

const loginSection = document.getElementById("loginSection");
const adminSection = document.getElementById("adminSection");
const tbody = document.getElementById("tableBody");
let unsubscribeSnapshot = null;

document.getElementById("loginBtn").addEventListener("click", async () => {
  const email = document.getElementById("email").value;
  const pass = document.getElementById("password").value;
  if (!email || !pass) return alert("Email dan password wajib diisi!");

  try {
    await signInWithEmailAndPassword(auth, email, pass);
    document.getElementById("password").value = "";
  } catch (e) {
    alert("Login gagal: Cek email/password atau nyalain Auth di Console.");
    console.error(e);
  }
});

document.getElementById("logoutBtn").addEventListener("click", () => {
  signOut(auth);
});

onAuthStateChanged(auth, (user) => {
  if (user) {
    loginSection.style.display = "none";
    adminSection.style.display = "block";

    unsubscribeSnapshot = onSnapshot(collection(db, "devices"), (snapshot) => {
      tbody.innerHTML = "";

      if (snapshot.empty) {
        tbody.innerHTML = `<tr><td colspan="3" style="text-align: center;">Belum ada perangkat terdaftar.</td></tr>`;
        return;
      }

      snapshot.forEach((docSnap) => {
        const data = docSnap.data();
        const tr = document.createElement("tr");
        tr.className = "hover:bg-gray-50 transition";

        let statusText = data.status ? data.status.toUpperCase() : "UNKNOWN";
        let statusClass;
        if (data.status === "online") {
          statusClass =
            "inline-block px-2.5 py-1 text-xs font-bold rounded-full bg-green-100 text-green-700";
        } else if (data.status === "offline") {
          statusClass =
            "inline-block px-2.5 py-1 text-xs font-bold rounded-full bg-red-100 text-red-700";
        } else {
          statusClass =
            "inline-block px-2.5 py-1 text-xs font-bold rounded-full bg-yellow-100 text-yellow-700";
        }

        let lastSeen = "-";
        if (data.lastSeen) {
          let date;
          if (data.lastSeen.seconds) {
            date = new Date(data.lastSeen.seconds * 1000);
          } else if (typeof data.lastSeen === "string") {
            date = new Date(data.lastSeen);
          }
          if (date && !isNaN(date)) {
            lastSeen = date.toLocaleString("id-ID", {
              day: "2-digit",
              month: "short",
              year: "numeric",
              hour: "2-digit",
              minute: "2-digit",
            });
          }
        }

        const claimedBy = data.userId || "-";

        tr.innerHTML = `
    <td class="py-3 px-4 font-semibold text-gray-800">${docSnap.id}</td>
    <td class="py-3 px-4"><span class="${statusClass}">${statusText}</span></td>
    <td class="py-3 px-4 text-gray-500">${lastSeen}</td>
    <td class="py-3 px-4 text-gray-500">${claimedBy}</td>
    <td class="py-3 px-4">
      <button class="delete-btn px-3 py-1.5 text-xs font-medium text-red-600 bg-red-50 hover:bg-red-100 rounded-lg transition" data-id="${docSnap.id}">
        Hapus
      </button>
    </td>
  `;
        tbody.appendChild(tr);
      });

      // Handle delete buttons
      tbody.addEventListener("click", async (e) => {
        const btn = e.target.closest(".delete-btn");
        if (!btn) return;
        const id = btn.dataset.id;
        if (!confirm(`Yakin hapus perangkat ${id}?`)) return;
        try {
          await deleteDoc(doc(db, "devices", id));
        } catch (err) {
          console.error("Gagal hapus:", err);
          alert("Gagal menghapus perangkat.");
        }
      });
    });
  } else {
    loginSection.style.display = "flex";
    adminSection.style.display = "none";

    if (unsubscribeSnapshot) unsubscribeSnapshot();
  }
});

document.getElementById("addBtn").addEventListener("click", async () => {
  const idInput = document.getElementById("deviceId");
  const id = idInput.value.trim();

  if (!id) return alert("ID Perangkat nggak boleh kosong!");

  try {
    await setDoc(doc(db, "devices", id), {
      status: "offline",
      lastSeen: new Date().toISOString(),
      userId: "admin",
    });
    idInput.value = "";
  } catch (e) {
    console.error("Error nambah dokumen: ", e);
    alert("Gagal nambah perangkat, pastikan status login aktif.");
  }
});
