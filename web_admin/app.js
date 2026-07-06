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

// --- ELEMEN MODAL QR ---
const qrModal = document.getElementById("qrModal");
const qrModalImg = document.getElementById("qrModalImg");
const qrModalTitle = document.getElementById("qrModalTitle");
const downloadQrBtn = document.getElementById("downloadQrBtn");
const closeModalBtn = document.getElementById("closeModalBtn");
let currentDownloadId = ""; // Untuk nama file saat didownload

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
        tbody.innerHTML = `<tr><td colspan="6" style="text-align: center;" class="py-4 text-gray-500">Belum ada perangkat terdaftar.</td></tr>`;
        return;
      }

      snapshot.forEach((docSnap) => {
        const data = docSnap.data();
        const tr = document.createElement("tr");
        tr.className = "hover:bg-gray-50 transition";

        let statusText = data.status ? data.status.toUpperCase() : "UNKNOWN";
        let statusClass =
          data.status === "online"
            ? "bg-green-100 text-green-700"
            : data.status === "offline"
              ? "bg-red-100 text-red-700"
              : "bg-yellow-100 text-yellow-700";
        statusClass = `inline-block px-2.5 py-1 text-xs font-bold rounded-full ${statusClass}`;

        let lastSeen = "-";
        if (data.lastSeen) {
          let date = data.lastSeen.seconds
            ? new Date(data.lastSeen.seconds * 1000)
            : new Date(data.lastSeen);
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
          <td class="py-3 px-4">
            <div id="qr-${docSnap.id}" data-id="${docSnap.id}" title="Klik untuk perbesar" class="qr-clickable cursor-pointer hover:scale-105 hover:shadow-md transition-all inline-flex items-center justify-center w-14 h-14 bg-white p-1 border rounded shadow-sm overflow-hidden"></div>
          </td>
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

        setTimeout(() => {
          const qrElement = document.getElementById(`qr-${docSnap.id}`);
          if (qrElement && window.QRCode) {
            qrElement.innerHTML = "";
            new window.QRCode(qrElement, {
              text: docSnap.id,
              width: 256,
              height: 256,
              colorDark: "#000000",
              colorLight: "#ffffff",
              correctLevel: window.QRCode.CorrectLevel.M,
            });
          }
        }, 0);
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
    alert("Gagal nambah perangkat.");
  }
});

tbody.addEventListener("click", async (e) => {
  const deleteBtn = e.target.closest(".delete-btn");
  if (deleteBtn) {
    const id = deleteBtn.dataset.id;
    if (!confirm(`Yakin hapus perangkat ${id}?`)) return;
    try {
      await deleteDoc(doc(db, "devices", id));
    } catch (err) {
      alert("Gagal menghapus perangkat.");
    }
    return;
  }

  const qrContainer = e.target.closest(".qr-clickable");
  if (qrContainer) {
    const id = qrContainer.dataset.id;

    const canvas = qrContainer.querySelector("canvas");
    if (canvas) {
      const dataURL = canvas.toDataURL("image/png");
      currentDownloadId = id;

      qrModalTitle.textContent = `ID: ${id}`;
      qrModalImg.src = dataURL;

      qrModal.classList.remove("hidden");
    } else {
      alert("QR Code sedang diproses, coba lagi dalam beberapa detik.");
    }
  }
});

const closeModal = () => {
  qrModal.classList.add("hidden");
  setTimeout(() => {
    qrModalImg.src = "";
  }, 200);
};

closeModalBtn.addEventListener("click", closeModal);

qrModal.addEventListener("click", (e) => {
  if (e.target === qrModal) closeModal();
});

downloadQrBtn.addEventListener("click", () => {
  if (!qrModalImg.src) return;

  const link = document.createElement("a");
  link.href = qrModalImg.src;
  link.download = `QR_${currentDownloadId}.png`;
  document.body.appendChild(link);
  link.click();
  document.body.removeChild(link);
});
