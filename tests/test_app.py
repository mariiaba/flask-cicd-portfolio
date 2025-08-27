from app.main import app

def test_hello():
    """
    Tests if the main page loads correctly.
    """
    client = app.test_client()
    response = client.get('/')
    assert response.status_code == 200
    assert b"Hello, DevOps World!" in response.data
