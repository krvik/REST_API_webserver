# REST_API_webserver
Repo contains, a simple REST API webserver where CRUD operation (Create, Read (all, by id), Update (all fields, some fields), and deletion of records performed. Also Health check and versioning of API.
----------------------------------------------------------------------------------------------------
# Create venv and install requirements
python -m venv venv
.\venv\Scripts\Activate.ps1
pip install -r requirements.txt

# Start the API
python .\app.py
see: Running on http://127.0.0.1:5000

# Health Check
Invoke-RestMethod http://localhost:5000/health
![alt text](image-2.png)


# Running Tests
pytest -q
![alt text](image.png)


# Base Paths
Legacy (alias to v1): http://localhost:5000/students/
v1: http://localhost:5000/api/v1/students/
v2: http://localhost:5000/api/v2/students/

# CRUD operation:
1. Create - POST
2. Read - list all - GET
3. Read- get by id - GET
4. update- replace all feilds - PUT
5. Pattial update - modify some feilds - PATCH
6. delete - DELETE



# Data model
{
  "id": 1,
  "name": "John",
  "age": 20,
  "course": "Math",
  "created_at": "2026-02-13T12:34:56.789012"
}
v2 response include extra key: "version"
![alt text](image-1.png)


# PowerShell (Invoke-RestMethod)
# Create (v1)
$body = @{ name='V1 User'; age=20; course='Math' } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:5000/api/v1/students/" -Method POST -ContentType "application/json" -Body $body

# List (v2)
Invoke-RestMethod -Uri "http://localhost:5000/api/v2/students/" -Method GET

# Patch (legacy → v1)
$patch = @{ age=21 } | ConvertTo-Json
Invoke-RestMethod -Uri "http://localhost:5000/students/1" -Method PATCH -ContentType "application/json" -Body $patch



# PowerShell (curl.exe)
curl.exe -X POST "http://localhost:5000/api/v2/students/" -H "Content-Type: application/json" -d "{\"name\":\"V2\",\"age\":21,\"course\":\"CS\"}"
curl.exe "http://localhost:5000/api/v2/students/"
curl.exe -X PATCH "http://localhost:5000/api/v2/students/1" -H "Content-Type: application/json" -d "{\"age\":22}"
curl.exe -X DELETE "http://localhost:5000/api/v2/students/1"


# To run via POSTMAN
1. Start API server         # App should show: Running on http://127.0.0.1:5000
2. run with NEWMan (CLI)
2.1. install node.js
2.2. install newman globally        npm install -g newman
2.3. Run collection json            newman run .\students_api_postman_collection.json --env-var baseUrl=http://localhost:5000 --env-var studentId=1

# To generate an HTML report
npm install -g newman-reporter-htmlextra

newman run .\students_api_postman_collection.json `
  --env-var baseUrl=http://localhost:5000 `
  --env-var studentId=1 `
  -r htmlextra `
  --reporter-htmlextra-export .\newman-report.html

![alt text](image-3.png)
