#!/usr/bin/env python3
"""
Upload log_sensor CSV ke Firestore.

Meniru persis skema uploadBarisCSV() / syncDataTertunda() di firmware ESP32:
  Path : users/{USER_ID}/devices/{DEVICE_ID}/sensorLogs/{timestamp}
  Field: kelembapanTanah, suhu (air_temp), kelembapanUdara,
         nitrogen, phosphor, kalium, ec  -> double
         recordedAt                      -> timestamp

Timestamp CSV dipakai sebagai document ID -> anti-duplikat (idempoten,
aman dijalankan ulang; baris yang sama akan menimpa, bukan menggandakan).

CARA PAKAI
----------
1) pip install google-cloud-firestore
2) Service account SUDAH TERTANAM di script (diambil dari firmware), jadi
   langsung bisa dipakai tanpa file JSON. Kalau mau pakai key sendiri:
   --key /path/key.json  atau  export GOOGLE_APPLICATION_CREDENTIALS=...
3) Jalankan bertahap (disarankan):
     python upload_ke_firestore.py --dry-run "log_sensor (5).csv"    # cek parsing
     python upload_ke_firestore.py --test-satu "log_sensor (5).csv"  # upload 1 baris + baca ulang
     python upload_ke_firestore.py "log_sensor (5).csv"              # upload semua
"""

import argparse
import csv
import os
import sys
from datetime import datetime, timezone

PROJECT_ID = "precision-farming-682c2"
DEVICE_ID = "KTANI-A1B2C3D4E5F6"

# Service account bawaan (diambil dari firmware). Dipakai kalau kamu TIDAK
# menyediakan file key sendiri. CATATAN KEAMANAN: kunci ini bocor di source
# firmware -> sebaiknya di-revoke & regenerate di Firebase Console setelah ini.
EMBEDDED_SA = {
    "type": "service_account",
    "project_id": PROJECT_ID,
    "client_email": "firebase-adminsdk-fbsvc@precision-farming-682c2.iam.gserviceaccount.com",
    "token_uri": "https://oauth2.googleapis.com/token",
    "private_key": (
        "-----BEGIN PRIVATE KEY-----\n"
        "MIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCk9ilG2YXAji6h\n"
        "1udEMEy/9f3CW6YKq+CxaCLDJVBJZjCKgLb74+51X3g2RK760LFSuHeEnI6RLydF\n"
        "YQzz6OGCj1iXAU3l/E0ftFTGFgwY5CVpu1eQegDGndOeQVkrsCjZZECLCbnAIxqS\n"
        "MW6QvyN4CwZfP9uJzOD+bXykGJGPqP95vDBrsHJ7Lq4iRpfKJld8tCe58AVpzZlx\n"
        "4AMCyQJ0hVNVWLcxNGaoVjPUyVgdDvD73XT3gJPwRimlXjRBTqFuFoEEqxofNrNP\n"
        "tDoTaH6tdId5IlqXmRZDZ7505bQVJZM2Zs0SL8d/Ak+RYbKFcsYB/LwDny6ZgIpH\n"
        "U49g9e61AgMBAAECggEAHDlV1J5xCQIKrnwDc6JD73AaK7/ch+Tie9gSYosm0nge\n"
        "hAQDytMzwHdGLRrRSW6deEbBhDn5FpQXxwIU4kKNGvaFtMhvWJMzauJCwuWQyk12\n"
        "rUF1eO225kSoqWIK7LOmOZOyi1dtpZcb+7ljbnaVjfts6q0VVd1s/XskITtm5EpC\n"
        "oZxZ8SblU1VQiTC4Nh6qrcr8ECRhZ1tVSC3MYYu5ipumzCHQI4WKeUDKpeq7M3oU\n"
        "a77QzB087nvVfFV9EEtoN2ZbRTJbWmgTDLI/qRwYcTJIPF/SwucerndyYfudZxK/\n"
        "+Nb0XcsVFeMK+YD1d6IgNqh7fjvlaXjrBtsns8vaHQKBgQDOAZAAytouuS4LYMw7\n"
        "tlcw29ZEb8XHoGrb5I6yqBvnbeT7viF47kaGCO5Fq+btEJP7k0fbcdpRM3XEPIcg\n"
        "r/7fz/gsYCPeEV5MfFEkzNXlSBBBj6oTGaCvdn0puUycqN0XHfUNa/GhPX6VljMi\n"
        "53SNkfKTbxcg6Nq/POVTvlvLUwKBgQDM/qU+jEsIUw3EMO5r5xY0Vs/T1JmS7Zni\n"
        "evXADoLAs0RqrppvqMi1kZw2+SjkxuivXjyX7O859ECQU8p3AAGvypRZieS2qPhD\n"
        "SJ2XA5fWcEPvXm4MTGhfXfqz7rdDykAmiR1/tN3xocnXsbbiKMRZKK2TqZKKc3oP\n"
        "oRAil0+k1wKBgQCqrYy7u1WNhItrjeVoS6htqJYb2WdJ/9TJHtJDnxiPY/Nlx58/\n"
        "7FqtzlRrkQMgwq14sAvG+stgn3wg++0Q3gATOuFpErZk1IsGX7FzBerprg0Z5IeK\n"
        "j58cANWubgHVgeq7rmxLlHV7m9F26hyv/IgKizMph87ny0UBUNjHy12OVQKBgQCC\n"
        "bzTti47iiRYlU40hEzTJsMMkYg4lsxFLTjm4LoN74ZUS3G5fxeGPxkrDn94pU3cS\n"
        "vr+HW7cMBSJfszEMbvCjzh5+qoLgxrrQ9Q9w21RtmZlgYZFcOfHfXIj8nFP3ymTv\n"
        "ICeo7oiaCvvHRsi7Nn1Yzc1EO42GktuDvlPp7qU6mQKBgCQZ8o+7+ejFcY/YlpW5\n"
        "25Yzf4kefhddAm5ZGv9cD/Nv1X1I4NQLVGbnhEEtYxIKFL+dSmd51zPeA5FqJ6Zc\n"
        "5DfAzkG5QXimLxdW/E7pBwJxN79uV/Vrqq/H/FnyOtJfu3u75SHFK+9xK7TWfQBY\n"
        "C1dF8E6SJ74Tegj5ir5Xw3dr\n"
        "-----END PRIVATE KEY-----\n"
    ),
}

# Kolom CSV (urutan sesuai header firmware):
# Timestamp,soil_moisture,soil_temperature,air_temperature,air_humidity,nitrogen,fosfor,kalium,ec


def parse_iso(ts: str) -> datetime:
    # Timestamp CSV format: 2026-07-05T09:07:11Z (UTC)
    return datetime.strptime(ts, "%Y-%m-%dT%H:%M:%SZ").replace(tzinfo=timezone.utc)


def to_double(s: str) -> float:
    try:
        return float(s)
    except (ValueError, TypeError):
        return 0.0


def build_fields(row: dict) -> dict:
    # Nama field SAMA PERSIS dengan uploadBarisCSV() di firmware.
    # Catatan: soil_temperature memang TIDAK dikirim firmware, jadi diikuti.
    return {
        "kelembapanTanah": to_double(row["soil_moisture"]),
        "suhu": to_double(row["air_temperature"]),        # air_temp -> "suhu"
        "kelembapanUdara": to_double(row["air_humidity"]),
        "nitrogen": to_double(row["nitrogen"]),
        "phosphor": to_double(row["fosfor"]),             # fosfor -> "phosphor"
        "kalium": to_double(row["kalium"]),
        "ec": to_double(row["ec"]),
        "recordedAt": parse_iso(row["Timestamp"]),        # timestampValue
    }


def get_user_id(db) -> str:
    """Baca userId dari devices/{DEVICE_ID}, persis seperti ambilUserID()."""
    snap = db.collection("devices").document(DEVICE_ID).get()
    if not snap.exists:
        raise SystemExit(
            f"[ERROR] Dokumen devices/{DEVICE_ID} tidak ada. "
            "Pastikan alat sudah diklaim (punya field userId)."
        )
    data = snap.to_dict() or {}
    uid = data.get("userId")
    if not uid:
        raise SystemExit(
            f"[ERROR] Field 'userId' tidak ada di devices/{DEVICE_ID}. "
            "Alat belum diklaim ke user mana pun."
        )
    return uid


def upload(csv_path="log_sensor (5).csv", user_id=None, key=None,
           dry_run=False, test_satu=False):
    """Logika inti. Bisa dipanggil langsung dari notebook, mis.:

        import upload_ke_firestore as u
        u.upload(test_satu=True)          # bukti 1 dokumen
        u.upload()                        # upload semua
    """
    if not os.path.exists(csv_path):
        raise SystemExit(f"[ERROR] File CSV tidak ditemukan: {csv_path}")

    # --- Baca & validasi CSV lebih dulu (tidak butuh internet) ---
    with open(csv_path, newline="", encoding="utf-8") as f:
        reader = csv.DictReader(f)
        rows = list(reader)

    expected = [
        "Timestamp", "soil_moisture", "soil_temperature", "air_temperature",
        "air_humidity", "nitrogen", "fosfor", "kalium", "ec",
    ]
    if reader.fieldnames != expected:
        print("[WARNING] Header CSV tidak persis seperti yang diharapkan.")
        print("  Ada  :", reader.fieldnames)
        print("  Harap:", expected)

    total = len(rows)
    print(f"[INFO] {total} baris dibaca dari {csv_path}")
    print(f"[INFO] Tujuan: users/<UID>/devices/{DEVICE_ID}/sensorLogs")

    if total:
        print("[INFO] Contoh baris pertama ->", build_fields(rows[0]))

    if dry_run:
        # Deteksi baris mencurigakan sekadar info (tetap diupload apa adanya).
        nol = sum(1 for r in rows if to_double(r["soil_moisture"]) == 0.0
                  and to_double(r["nitrogen"]) == 0.0)
        print(f"[DRY-RUN] {nol} baris terlihat all-zero (tetap akan diupload jika bukan dry-run).")
        print("[DRY-RUN] Tidak ada yang ditulis ke Firestore.")
        return

    # --- Baru sekarang butuh library + kredensial ---
    try:
        from google.cloud import firestore
    except ImportError:
        raise SystemExit(
            "[ERROR] Library belum terpasang. Jalankan:\n"
            "  pip install google-cloud-firestore"
        )

    key_path = key or os.environ.get("GOOGLE_APPLICATION_CREDENTIALS")
    if not key_path and os.path.exists("serviceAccountKey.json"):
        key_path = "serviceAccountKey.json"

    if key_path and os.path.exists(key_path):
        db = firestore.Client.from_service_account_json(key_path, project=PROJECT_ID)
        print(f"[INFO] Pakai service account file: {key_path}")
    else:
        # Fallback: pakai kunci tertanam dari firmware.
        from google.oauth2 import service_account
        creds = service_account.Credentials.from_service_account_info(EMBEDDED_SA)
        db = firestore.Client(project=PROJECT_ID, credentials=creds)
        print("[INFO] Pakai service account TERTANAM (dari firmware).")

    uid = user_id or get_user_id(db)
    print(f"[INFO] USER_ID = {uid}")

    sensor_col = (
        db.collection("users").document(uid)
        .collection("devices").document(DEVICE_ID)
        .collection("sensorLogs")
    )

    # --- MODE UJI: upload 1 baris (auto-ID), lalu baca ulang sebagai bukti ---
    if test_satu:
        row = rows[0]
        fields = build_fields(row)
        _, doc_ref = sensor_col.add(fields)   # auto-ID acak
        print(f"[TEST] Menulis 1 dokumen dengan auto-ID: {doc_ref.id}")

        snap = doc_ref.get()
        if snap.exists:
            print("[TEST] BERHASIL. Dokumen terbaca kembali dari Firestore:")
            print(f"       path : {snap.reference.path}")
            for k, v in (snap.to_dict() or {}).items():
                print(f"       {k} = {v}")
        else:
            print("[TEST] GAGAL. Dokumen tidak ditemukan setelah ditulis.")
        return

    # --- Hapus isi lama collection dulu (bersih sebelum upload) ---
    print("[INFO] Menghapus dokumen lama di sensorLogs...")
    dihapus = 0
    while True:
        batch_del = db.batch()
        docs = list(sensor_col.limit(500).stream())
        if not docs:
            break
        for d in docs:
            batch_del.delete(d.reference)
        batch_del.commit()
        dihapus += len(docs)
        print(f"[INFO] {dihapus} dokumen lama dihapus...")
    print(f"[INFO] Total {dihapus} dokumen lama dihapus.")

    # Batched write: 500 operasi per commit (batas Firestore). Auto-ID acak.
    BATCH = 500
    terkirim = 0
    batch = db.batch()
    for row in rows:
        ts = row["Timestamp"].strip()
        if not ts:
            continue
        doc_ref = sensor_col.document()     # auto-ID acak
        batch.set(doc_ref, build_fields(row))
        terkirim += 1

        if terkirim % BATCH == 0:
            batch.commit()
            print(f"[OK] {terkirim}/{total} terkirim...")
            batch = db.batch()

    if terkirim % BATCH != 0:
        batch.commit()

    print(f"[SELESAI] {terkirim} baris berhasil diupload ke Firestore.")


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument(
        "csv_path",
        nargs="?",
        default="log_sensor (5).csv",
        help="Path file CSV (default: 'log_sensor (5).csv')",
    )
    ap.add_argument(
        "--user-id",
        default=None,
        help="USER_ID manual. Kalau kosong, dibaca otomatis dari devices/DEVICE_ID.",
    )
    ap.add_argument(
        "--key",
        default=None,
        help="Path service account JSON. Kalau kosong, pakai kunci tertanam.",
    )
    ap.add_argument(
        "--dry-run",
        action="store_true",
        help="Cuma baca & tampilkan ringkasan, TIDAK menulis ke Firestore.",
    )
    ap.add_argument(
        "--test-satu",
        action="store_true",
        help="Upload HANYA baris pertama, lalu baca ulang dari Firestore "
        "dan tampilkan isinya sebagai bukti tulis berhasil.",
    )
    # Abaikan argumen tak dikenal (mis. --f=...kernel.json dari Jupyter).
    args, _ = ap.parse_known_args()

    upload(
        csv_path=args.csv_path,
        user_id=args.user_id,
        key=args.key,
        dry_run=args.dry_run,
        test_satu=args.test_satu,
    )


if __name__ == "__main__":
    main()
