import pytest
from fastapi.testclient import TestClient
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.pool import StaticPool

from app.database import Base, get_db
from app.main import app


@pytest.fixture
def client():
    engine = create_engine(
        "sqlite://",
        connect_args={"check_same_thread": False},
        poolclass=StaticPool,
    )
    TestingSession = sessionmaker(bind=engine, autoflush=False, autocommit=False)
    Base.metadata.create_all(bind=engine)

    def override_get_db():
        db = TestingSession()
        try:
            yield db
        finally:
            db.close()

    app.dependency_overrides[get_db] = override_get_db
    yield TestClient(app)
    app.dependency_overrides.clear()


def test_create_item(client):
    response = client.post("/items", json={"name": "Pen", "description": "Blue pen"})
    assert response.status_code == 201
    data = response.json()
    assert data["id"] == 1
    assert data["name"] == "Pen"
    assert data["description"] == "Blue pen"


def test_list_items_empty(client):
    response = client.get("/items")
    assert response.status_code == 200
    assert response.json() == []


def test_list_items_returns_created_items(client):
    client.post("/items", json={"name": "Pen", "description": "Blue pen"})
    client.post("/items", json={"name": "Book", "description": "A book"})
    response = client.get("/items")
    assert response.status_code == 200
    assert [item["name"] for item in response.json()] == ["Pen", "Book"]


def test_empty_name_is_rejected(client):
    response = client.post("/items", json={"name": "", "description": "x"})
    assert response.status_code == 422


def test_blank_name_is_rejected(client):
    response = client.post("/items", json={"name": "   ", "description": "x"})
    assert response.status_code == 422


def test_missing_name_is_rejected(client):
    response = client.post("/items", json={"description": "x"})
    assert response.status_code == 422