import logging
import pytest

from pathlib import Path

from webtest import TestApp
from sqlalchemy.sql import text
from sqlalchemy.exc import OperationalError

from {{cookiecutter.app_name}} import create_app
from {{cookiecutter.app_name}}.extensions import db as _db


_res = Path(__file__).parent.absolute() / Path("resources")


@pytest.fixture(scope="session")
def test_settings() -> dict:
    return {
        "ENV": "development",
        "FLASK_SECRET_KEY": "woo",
        "SQLALCHEMY_DATABASE_URI": "mysql+pymysql://{{cookiecutter.app_name}}:test@localhost/{{cookiecutter.app_name}}_test",
        "SQLALCHEMY_TRACK_MODIFICATIONS": False,
        "PRESERVE_CONTEXT_ON_EXCEPTION": False,
    }


@pytest.fixture(scope="session")
def app(test_settings):
    """Create application for the tests."""
    _app = create_app(test_settings)
    _app.logger.setLevel(logging.ERROR)
    _app.config["TESTING"] = True
    ctx = _app.test_request_context()
    ctx.push()

    yield _app

    ctx.pop()


@pytest.fixture(scope="session")
def db(app):
    _db.app = app
    with app.app_context():
        for file in ["example_db.sql", "example_data.sql"]:
            with open(_res / Path(file), "r") as fp:
                query = text(fp.read())
                _db.session.execute(query)
                _db.session.commit()
                _db.session.flush()
    yield _db
    _db.session.execute(text("DROP TABLE log;"))
    _db.session.close()


@pytest.fixture(scope="session")
def testapp(app, db):
    return TestApp(app)
