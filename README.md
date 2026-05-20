# Fuseki Railway Deploy

Apache Jena Fuseki untuk dataset Hadis Arbain Nawawi, di-deploy ke Railway.

## Struktur Folder

```
fuseki-railway/
├── Dockerfile
├── entrypoint.sh
├── dataset_hadits.ttl      ← konfigurasi dataset Fuseki
├── railway.json
├── .gitignore
├── README.md
└── data/                   ← ⚠️ TARUH FILE TTL KAMU DI SINI
    ├── knowledge_graph.ttl
    └── ontology_schema.ttl
```

## Langkah Deploy

### 1. Siapkan file TTL
Taruh file `knowledge_graph.ttl` dan `ontology_schema.ttl` ke dalam folder `data/`.

### 2. Push ke GitHub
```bash
git init
git add .
git commit -m "fuseki railway deploy"
git branch -M main
git remote add origin https://github.com/USERNAME/fuseki-hadits.git
git push -u origin main
```

### 3. Deploy ke Railway
1. Buka https://railway.app → Login dengan GitHub
2. Klik **New Project** → **Deploy from GitHub repo**
3. Pilih repo `fuseki-hadits`
4. Railway otomatis detect Dockerfile dan mulai build
5. Setelah deploy, klik **Settings** → **Networking** → **Generate Domain**
6. Copy URL yang diberikan, contoh: `https://fuseki-hadits-production.up.railway.app`

### 4. Update app.py
Ganti `FUSEKI_ENDPOINT` di `app.py`:
```python
FUSEKI_ENDPOINT = "https://fuseki-hadits-production.up.railway.app/dataset_hadits/query"
```

### 5. Test
Buka URL Railway di browser, seharusnya muncul halaman Fuseki UI.

## Environment Variables (opsional ubah di Railway)

| Variable | Default | Keterangan |
|----------|---------|------------|
| `ADMIN_PASSWORD` | `admin123` | Password admin Fuseki |
| `JVM_ARGS` | `-Xmx512m` | Memory Java (free tier max ~512MB) |

## Catatan

- Free tier Railway: 500 jam/bulan, cukup untuk demo
- Dataset otomatis dimuat dari folder `data/` saat container pertama kali jalan
- Kalau mau tambah data setelah deploy, upload lewat Fuseki UI → Add Data
