import unittest
import sys
import os
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), '../src')))

from app import app


class BasicTestCase(unittest.TestCase):
    def setUp(self):
        self.client = app.test_client()
    def test_home(self):
        response = self.client.get("/")
        assert response.status_code == 200
        assert b"Hello from CI/CD Flask app!" in response.data

if __name__ == '__main__':
    unittest.main()

