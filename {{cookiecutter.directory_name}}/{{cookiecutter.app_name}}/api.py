from flask import Blueprint, request, jsonify
from sqlalchemy.sql import text

from {{cookiecutter.app_name}}.extensions import db


bp = Blueprint(
    "api",
    __name__,
    url_prefix="/api",
    template_folder="templates",
    static_folder="static",
)


@bp.route("/person", methods=("GET", ))
def byhash():
	id_ = int(request.args.get("id"))

	if not hash_:
		return "Bad Request", 400

	query = text("SELECT name FROM log WHERE id = :id")
	res = db.session.execute(query, {"id": id_})
	first = res.first()
	if first:
		return {"name": first["name"]}
	return {}
