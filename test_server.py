import pytest
from server import app, run_cycle


@pytest.fixture
def client():
    app.config['TESTING'] = True
    with app.test_client() as client:
        yield client


def test_health(client):
    """Test health endpoint returns 200."""
    response = client.get('/health')
    assert response.status_code == 200
    assert response.json['status'] == 'healthy'


def test_cycle_endpoint(client):
    """Test cycle endpoint accepts POST requests."""
    payload = {'test': 'data'}
    response = client.post('/cycle', json=payload)
    assert response.status_code == 200
    assert response.json['status'] == 'ok'
    assert response.json['payload'] == payload


def test_cycle_endpoint_invalid_method(client):
    """Test cycle endpoint rejects GET requests."""
    response = client.get('/cycle')
    assert response.status_code == 405
