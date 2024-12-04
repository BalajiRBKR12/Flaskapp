import pytest
from app import app, db, User

@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        with app.app_context():
            db.create_all()
        yield client
        with app.app_context():
            db.drop_all()

def test_create_user(client):
    response = client.post('/users', json={'name': 'John', 'email': 'john@example.com'})
    assert response.status_code == 201
    assert response.get_json()['id'] == 1
