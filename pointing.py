import requests
import json
import random
import string

# Konfigurasi Cloudflare
CF_API_KEY = 'lXHXIwv46lMTVfTisggCnUqkW0g2Wf0C_ZV6OAbj'  # Ganti dengan Cloudflare API Key Anda
CF_EMAIL = 'mezzqueen293@gmail.com'  # Ganti dengan email Cloudflare Anda
CF_ZONE_ID = '2d62a9ab267ce5b012e5152f4f40e4e2'  # Ganti dengan Zone ID domain Anda
DOMAIN = 'lu-bau.my.id'  # Ganti dengan domain Anda

# Mendapatkan IP VPS otomatis
VPS_IP = requests.get("https://ipv4.icanhazip.com").text.strip()

# Fungsi untuk membuat subdomain acak
def generate_random_subdomain(length=8):
    """Membuat subdomain acak dengan panjang tertentu."""
    return ''.join(random.choices(string.ascii_lowercase + string.digits, k=length)) + "." + DOMAIN

# Nama subdomain acak
RECORD_NAME = generate_random_subdomain()

# URL API Cloudflare
CF_API_URL = 'https://api.cloudflare.com/client/v4/zones/{}/dns_records'.format(CF_ZONE_ID)

# Header untuk API request
headers = {
    'X-Auth-Email': CF_EMAIL,
    'X-Auth-Key': CF_API_KEY,
    'Content-Type': 'application/json'
}

def get_dns_records():
    """Mengambil daftar DNS records untuk zone di Cloudflare"""
    response = requests.get(CF_API_URL, headers=headers)
    if response.status_code == 200:
        return response.json()['result']
    else:
        print(f"Failed to retrieve DNS records: {response.status_code}")
        return []

def create_or_update_dns_record():
    """Membuat atau memperbarui DNS record untuk subdomain di Cloudflare"""
    # Cek apakah DNS record sudah ada
    records = get_dns_records()
    record_exists = False
    record_id = None

    for record in records:
        if record['name'] == RECORD_NAME:
            record_exists = True
            record_id = record['id']
            break

    # Data DNS record
    dns_data = {
        'type': 'A',  # Menggunakan tipe A record untuk mengarahkan domain ke IP
        'name': RECORD_NAME,
        'content': VPS_IP,
        'ttl': 1,  # TTL 1 berarti menggunakan default
        'proxied': False  # Ganti menjadi True jika ingin menggunakan proxy Cloudflare
    }

    if record_exists:
        # Update DNS record yang ada
        update_url = f"{CF_API_URL}/{record_id}"
        response = requests.put(update_url, headers=headers, data=json.dumps(dns_data))
        if response.status_code == 200:
            print(f"DNS record untuk {RECORD_NAME} berhasil diperbarui.")
        else:
            print(f"Gagal memperbarui DNS record: {response.status_code}")
    else:
        # Membuat DNS record baru
        response = requests.post(CF_API_URL, headers=headers, data=json.dumps(dns_data))
        if response.status_code == 200:
            print(f"DNS record untuk {RECORD_NAME} berhasil dibuat.")
        else:
            print(f"Gagal membuat DNS record: {response.status_code}")

if __name__ == '__main__':
    print(f"Subdomain yang dibuat: {RECORD_NAME}")
    create_or_update_dns_record()
