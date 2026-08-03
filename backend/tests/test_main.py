from fastapi.testclient import TestClient
from app.main import app

client = TestClient(app)

def test_health():
    response = client.get("/health")
    assert response.status_code == 200
    assert response.json() == {"status": "healthy", "database": "connected"}

def test_metrics():
    response = client.get("/metrics")
    assert response.status_code == 200
    assert "app_requests_total" in response.text

def test_create_and_get_item():
    # Test POST creation
    response = client.post("/items?name=TestItem&description=TestDescription")
    assert response.status_code == 201
    data = response.json()
    assert "id" in data
    assert data["name"] == "TestItem"
    assert data["description"] == "TestDescription"
    
    # Test GET list
    response = client.get("/items")
    assert response.status_code == 200
    items = response.json()
    assert len(items) > 0
    assert items[-1]["name"] == "TestItem"
